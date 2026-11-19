import "../../singletons"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: netRow.implicitWidth + (Theme.radius * 2)
    implicitHeight: Theme.height
    radius: Theme.radius
    color: Theme.colBg

    RowLayout {
        id: netRow

        anchors.centerIn: parent
        height: parent.height
        spacing: 2

        Text {
            id: wifiText
            text: NetworkService.wifiIcon
            color: Theme.colFg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }

        Text {
            text: "|"
            color: Theme.colFg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }

        Text {
            id: btText
            text: NetworkService.btIcon
            color: Theme.colFg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }
    }
}
