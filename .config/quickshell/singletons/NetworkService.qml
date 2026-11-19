pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool wifiEnabled: false
    property bool wifiConnected: false
    property string wifiSsid: ""
    property int wifiSignal: 0
    property string wifiSpeed: ""
    property string wifiIp: ""

    property bool btEnabled: false
    property bool btConnected: false
    property string btDeviceName: "Disconnected"
    property string btDeviceMac: ""
    property int btBattery: -1

    readonly property string wifiIcon: {
        if (wifiConnected)
            return Icons.iWiFiConnected;
        else if (wifiEnabled)
            return Icons.iWiFiEnabled;
        else
            return Icons.iWiFiDisabled;
    }

    readonly property string btIcon: {
        if (btConnected)
            return Icons.iBTConnected;
        if (btEnabled)
            return Icons.iBTEnabled;
        else
            return Icons.iBTDisabled;
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", "echo \"RADIO:$(nmcli radio wifi)\"; " + "nmcli -t -f ACTIVE,SSID,SIGNAL,RATE,DEVICE dev wifi | grep '^yes' | head -n1; " + "ip -4 -o addr show scope global | awk '{print \"IP:\" $4}' | head -n1"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split("\n");
                let enabled = false;
                let connected = false;
                let ssid = "Disconnected";
                let signal = 0;
                let speed = "";
                let ip = "";

                for (const line of lines) {
                    if (line.startsWith("RADIO:")) {
                        enabled = (line.split(":")[1]?.trim() === "enabled");
                    } else if (line.startsWith("yes:")) {
                        connected = true;
                        const parts = line.split(":");
                        ssid = parts[1] || "Connected";
                        signal = parseInt(parts[2]) || 0;
                        speed = parts[3] || "";
                    } else if (line.startsWith("IP:")) {
                        ip = line.substring(3).split("/")[0] || "";
                    }
                }

                root.wifiEnabled = enabled;
                root.wifiConnected = connected;
                root.wifiSsid = connected ? ssid : (enabled ? "Not Connected" : "Disabled");
                root.wifiSignal = signal;
                root.wifiSpeed = speed;
                root.wifiIp = ip;

                console.log(wifiConnected);
            }
        }
    }

    Process {
        id: btProc
        command: ["sh", "-c", "echo \"POWER:$(bluetoothctl show | awk '/Powered:/ {print $2}')\"; " + "bluetoothctl devices Connected | head -n1"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split("\n");
                let powered = false;
                let connected = false;
                let name = "Disconnected";
                let mac = "";

                for (const line of lines) {
                    if (line.startsWith("POWER:")) {
                        powered = (line.split(":")[1]?.trim() === "yes");
                    } else if (line.startsWith("Device ")) {
                        // Format: Device XX:XX:XX:XX:XX:XX Device Name
                        connected = true;
                        const firstSpace = line.indexOf(" ");
                        const secondSpace = line.indexOf(" ", firstSpace + 1);
                        mac = line.substring(firstSpace + 1, secondSpace);
                        name = line.substring(secondSpace + 1) || "Connected Device";
                    }
                }

                root.btEnabled = powered;
                root.btConnected = connected;
                root.btDeviceName = connected ? name : (powered ? "Not Connected" : "Disabled");
                root.btDeviceMac = mac;

                if (connected && mac !== "") {
                    btBatteryProc.mac = mac;
                    btBatteryProc.running = true;
                } else {
                    root.btBattery = -1;
                }
            }
        }
    }

    Process {
        id: btBatteryProc
        property string mac: ""
        command: ["sh", "-c", `bluetoothctl info "${mac}" | awk -F'[()]' '/Battery Percentage:/ {print $2}'`]

        stdout: StdioCollector {
            onStreamFinished: {
                const val = parseInt(this.text.trim());
                root.btBattery = isNaN(val) ? -1 : val;
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            wifiProc.running = true;
            btProc.running = true;
        }
    }
}
