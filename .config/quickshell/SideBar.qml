import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "./singletons/"
import "./widgets/Controls/" as Pl

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: sidebarWindow
        required property var modelData

        readonly property bool isPlayerActive: PlayerService.status === "Playing" || PlayerService.status === "Paused"
        property bool userVisible: true

        onIsPlayerActiveChanged: {
            if (!isPlayerActive) {
                userVisible = true;
            }
        }

        visible: userVisible && isPlayerActive

        screen: modelData
        anchors.left: true
        anchors.top: true
        anchors.bottom: true
        implicitWidth: 30
        color: "transparent"

        RowLayout {
            anchors.centerIn: parent
            width: parent.height
            height: parent.width
            rotation: -90

            spacing: 8

            Item {
                Layout.fillWidth: true
            }

            Pl.Player {}

            Item {
                Layout.fillWidth: true
            }
        }

        GlobalShortcut {
            name: "togglePanel"
            description: "Toggle Quickshell top bar"
            onPressed: {
                sidebarWindow.userVisible = !sidebarWindow.userVisible;
            }
        }
    }
}
