import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property int cpuUsage: 0
    property int ramUsage: 0
    property int homeUsage: 0
    property int bootUsage: 0
    property real avgFreqMhz: 0
    property real maxFreqMhz: 4000
    property var perCoreStats: []
    property real ramPercent: 0
    property int ramUsedMiB: 0
    property int ramTotalMiB: 0
    property real homePercent: 0
    property string homeUsed: "000.00G"
    property string homeTotal: "000.00G"
    property real bootPercent: 0
    property string bootUsed: "0.00G"
    property string bootTotal: "0.00G"
    property real lastCpuTotal: 0
    property real lastCpuIdle: 0
    property var lastCoreTotals: ({
    })
    property var lastCoreIdles: ({
    })
    property var latestCoreFreqs: []

    FileView {
        id: statFile

        path: "/proc/stat"
        onLoaded: {
            var lines = text().split("\n");
            var cores = [];
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i].trim();
                if (!line.startsWith("cpu"))
                    continue;

                var p = line.split(/\s+/);
                var name = p[0];
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => {
                    return a + parseInt(b);
                }, 0);
                if (name === "cpu") {
                    if (root.lastCpuTotal > 0 && total > root.lastCpuTotal)
                        root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)));

                    root.lastCpuTotal = total;
                    root.lastCpuIdle = idle;
                } else {
                    var coreIdx = parseInt(name.replace("cpu", ""));
                    var prevTotal = root.lastCoreTotals[name] || 0;
                    var prevIdle = root.lastCoreIdles[name] || 0;
                    var usage = 0;
                    if (prevTotal > 0 && total > prevTotal)
                        usage = Math.round(100 * (1 - (idle - prevIdle) / (total - prevTotal)));

                    root.lastCoreTotals[name] = total;
                    root.lastCoreIdles[name] = idle;
                    var freq = root.latestCoreFreqs[coreIdx] || 0;
                    cores.push({
                        "name": name,
                        "usage": usage,
                        "freq": freq
                    });
                }
            }
            root.perCoreStats = cores;
        }
    }

    FileView {
        id: cpuInfoFile

        path: "/proc/cpuinfo"
        onLoaded: {
            var lines = text().split("\n");
            var freqs = [];
            var sum = 0;
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i];
                if (line.startsWith("cpu MHz")) {
                    var val = parseFloat(line.split(":")[1].trim());
                    if (!isNaN(val)) {
                        var rounded = Math.round(val);
                        freqs.push(rounded);
                        sum += val;
                    }
                }
            }
            root.latestCoreFreqs = freqs;
            if (freqs.length > 0)
                root.avgFreqMhz = Number((sum / freqs.length).toFixed(1));

        }
    }

    FileView {
        id: memFile

        path: "/proc/meminfo"
        onLoaded: {
            var lines = text().split("\n");
            var memTotalKb = 0;
            var memAvailKb = 0;
            for (var i = 0; i < lines.length; i++) {
                var line = lines[i];
                if (line.startsWith("MemTotal:"))
                    memTotalKb = parseInt(line.split(/\s+/)[1]);
                else if (line.startsWith("MemAvailable:"))
                    memAvailKb = parseInt(line.split(/\s+/)[1]);
            }
            if (memTotalKb > 0) {
                var usedKb = memTotalKb - memAvailKb;
                root.ramTotalMiB = Math.round(memTotalKb / 1024);
                root.ramUsedMiB = Math.round(usedKb / 1024);
                var pct = (usedKb / memTotalKb) * 100;
                root.ramPercent = Number(pct.toFixed(2));
                root.ramUsage = Math.round(pct);
            }
        }
    }

    Process {
        id: dfProc

        command: ["df", "-B1", "/home", "/boot"]

        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.trim().split("\n");
                for (var i = 1; i < lines.length; i++) {
                    var p = lines[i].trim().split(/\s+/);
                    if (p.length < 6)
                        continue;

                    var totalBytes = parseFloat(p[1]);
                    var usedBytes = parseFloat(p[2]);
                    var mount = p[p.length - 1];
                    var pct = totalBytes > 0 ? (usedBytes / totalBytes) * 100 : 0;
                    var usedG = (usedBytes / (1024 * 1024 * 1024)).toFixed(2) + "G";
                    var totalG = (totalBytes / (1024 * 1024 * 1024)).toFixed(2) + "G";
                    if (mount === "/home" || mount === "/") {
                        root.homePercent = Number(pct.toFixed(2));
                        root.homeUsage = Math.round(pct);
                        root.homeUsed = usedG;
                        root.homeTotal = totalG;
                    } else if (mount === "/boot" || mount === "/boot/efi" || mount === "/efi") {
                        root.bootPercent = Number(pct.toFixed(2));
                        root.bootUsage = Math.round(pct);
                        root.bootUsed = usedG;
                        root.bootTotal = totalG;
                    }
                }
            }
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            cpuInfoFile.reload();
            statFile.reload();
            memFile.reload();
            dfProc.running = true;
        }
    }

}
