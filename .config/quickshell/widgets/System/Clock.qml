import "../../singletons"
import "../../utils/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: timeText.implicitWidth + 16
    implicitHeight: 30
    radius: 8
    color: Theme.col2

    Text {
        id: timeText

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: DateTime.time
        color: Theme.colFg

        font {
            pixelSize: Theme.fontSize
            bold: true
            family: Theme.fontFamily
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }

        Tooltip {
            target: mouseArea.parent
            show: mouseArea.containsMouse
            text: DateTime.datetime
        }

    }

}
