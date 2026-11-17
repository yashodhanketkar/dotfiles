import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

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
            }

        }

    }

}
