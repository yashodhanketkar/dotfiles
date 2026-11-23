import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "widgets/Hyprland" as Hypr
import "widgets/Controls" as Ctrl
import "widgets/System" as Sys
import "widgets/Notifications" as Noti

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: barWindow
        required property var modelData

        visible: true

        screen: modelData
        anchors.top: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 30 + 10
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            spacing: 8

            Ctrl.Volume {}
            Ctrl.Brightness {}
            Sys.Network {}

            Item {
                Layout.fillWidth: true
            }

            Hypr.Workspace {
                screen: barWindow.screen
            }

            Item {
                Layout.fillWidth: true
            }

            Sys.Battery {}
            Sys.Stats {}
            Sys.Clock {}
            Noti.Notification {}
        }

        GlobalShortcut {
            name: "togglePanel"
            description: "Toggle Quickshell top bar"
            onPressed: {
                barWindow.visible = !barWindow.visible;
            }
        }
    }
}
