import "../../singletons/"
import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root

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
