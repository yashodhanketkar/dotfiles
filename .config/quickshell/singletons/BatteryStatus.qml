import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    id: root

    property string state: "unknown"
    property string charge: "0"

    Process {
        id: batStateProc

        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]

        stdout: StdioCollector {
            onStreamFinished: {
                const match = this.text.match(/^\s*state:\s*(\S+)/m);
                if (match)
                    root.state = match[1];

            }
        }

    }

    Process {
        id: batChargeProc

        command: ["upower", "-i", "/org/freedesktop/UPower/devices/battery_BAT0"]

        stdout: StdioCollector {
            onStreamFinished: {
                const match = this.text.match(/^\s*percentage:\s*(\S+)/m);
                if (match)
                    root.charge = match[1];

            }
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            batStateProc.running = true;
            batChargeProc.running = true;
        }
    }

}
