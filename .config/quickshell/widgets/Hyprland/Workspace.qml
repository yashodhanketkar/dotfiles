pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../components/"

Rectangle {
    id: root

    required property ShellScreen screen

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: wsRow.implicitWidth
    implicitHeight: 30
    radius: 8
    color: "transparent"

    RowLayout {
        id: wsRow

        anchors.centerIn: parent
        height: parent.height
        spacing: 2

        Repeater {
            model: 10

            WorkspaceItem {
                screen: root.screen
            }
        }
    }
}
