pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int brightness: 50

    property bool kdbBacklit: false

    property bool hasExternalMonitor: false
    property int externalBrightness: 50
    property int externalBus: -1

    property bool nightMode: false

    function getBrightness() {
        getBrightnessProc.running = true;
    }

    function setBrightness(newValue) {
        const clamped = Math.max(1, Math.min(100, Math.round(newValue)));
        root.brightness = clamped;

        setBrightnessProc.command = ["brightnessctl", "set", clamped + "%"];
        setBrightnessProc.running = true;
    }

    function setKbdBacklit() {
        const targetValue = root.kdbBacklit ? "0%" : "100%";

        setBrightnessProc.command = ["brightnessctl", "-d", "platform::kbd_backlight", "set", targetValue];
        setBrightnessProc.running = true;
    }

    function refreshExternalMonitor() {
        if (!detectExternalProc.running) {
            detectExternalProc.running = true;
        }
    }

    function setExternalBrightness(newValue) {
        if (!root.hasExternalMonitor)
            return;

        const clamped = Math.max(0, Math.min(100, Math.round(newValue)));
        root.externalBrightness = clamped;

        externalDebounceTimer.pendingValue = clamped;
        externalDebounceTimer.restart();
    }

    function setAllBrightness(newValue) {
        setBrightness(newValue);
        if (root.hasExternalMonitor) {
            setExternalBrightness(newValue);
        }
    }

    function toggleNightMode() {
        toggleNightModeProc.command = ["louarch", "osmode", "night"];
        toggleNightModeProc.running = true;
    }

    Process {
        id: getBrightnessProc
        running: true
        command: ["brightnessctl", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(",");
                if (parts.length >= 5) {
                    root.brightness = parseInt(parts[3]);
                }
            }
        }
    }

    Process {
        id: setBrightnessProc
    }

    Process {
        id: getKbdBacklitProc
        running: true
        command: ["brightnessctl", "-d", "platform::kbd_backlight", "-m"]
        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.trim().split(",");
                if (parts.length >= 5) {
                    root.kdbBacklit = parseInt(parts[3]) !== 0;
                }
            }
        }
    }

    Process {
        id: setKbdBacklitProc
    }

    Process {
        id: detectExternalProc
        running: true
        command: ["sh", "-c", "ddcutil -d 1 getvcp 10 --brief 2>/dev/null | awk '{print $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                const val = parseInt(this.text.trim(), 10);
                root.hasExternalMonitor = !isNaN(val);
                if (!isNaN(val)) {
                    root.externalBrightness = val;
                }
            }
        }
    }

    Timer {
        id: externalDebounceTimer
        interval: 150
        property int pendingValue: 50
        onTriggered: {
            setExternalProc.command = ["ddcutil", "-d", "1", "setvcp", "10", pendingValue.toString()];
            setExternalProc.running = true;
        }
    }

    Process {
        id: setExternalProc
    }

    Process {
        id: getNightModeProc
        running: true
        command: ["pgrep", "-x", "hyprsunset"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.nightMode = this.text.trim() !== "";
            }
        }
    }

    Process {
        id: toggleNightModeProc
    }

    Timer {
        interval: 300
        running: true
        repeat: true
        onTriggered: {
            getNightModeProc.running = true;
            getBrightnessProc.running = true;
            getKbdBacklitProc.running = true;
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refreshExternalMonitor()
    }
}
