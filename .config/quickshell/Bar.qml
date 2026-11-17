import Quickshell
import QtQuick
import QtQuick.Layouts
import "widgets/Hyprland" as Hypr
import "widgets/System" as Sys

Scope {
    id: root
    Variants {
        model: Quickshell.screens

        PanelWindow {
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

                Hypr.Workspace {}

                Item {
                    Layout.fillWidth: true
                }

                Sys.Battery {}
                Sys.Stats {}
                Sys.Clock {}
            }
        }
    }
}
