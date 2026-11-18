pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int brightness: 50
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

    function toggleNightMode() {
        root.nightMode = !root.nightMode;
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
                    root.brightness = parseInt(parts[2]);
                }
            }
        }
    }

    Process {
        id: setBrightnessProc
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
        }
    }
}
