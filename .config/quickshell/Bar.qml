import QtQuick
import QtQuick.Layouts
import Quickshell
import "widgets/Hyprland" as Hypr
import "widgets/Controls" as Ctrl
import "widgets/System" as Sys
import "widgets/Notifications" as Noti

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: barWindow
        required property var modelData

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

            Hypr.Workspace {
                screen: barWindow.screen
            }
            Ctrl.Volume {}
            Ctrl.Brightness {}

            Item {
                Layout.fillWidth: true
            }

            Sys.Battery {}
            Sys.Stats {}
            Sys.Clock {}
            Noti.Notification {}
        }
    }
}
