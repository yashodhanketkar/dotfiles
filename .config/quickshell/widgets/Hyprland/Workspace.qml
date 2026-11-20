pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../components/"
import "../../singletons/"

Rectangle {
    id: root

    required property ShellScreen screen

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: wsRow.implicitWidth
    implicitHeight: Theme.height
    radius: Theme.radius
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
