import "../../singletons/"
import "../"
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
        opacity: NetworkService.wifiConnected ? 1.0 : 0.5
    }

    Spacer {
        isVisible: true
        compact: false
    }

    Text {
        id: btText
        text: NetworkService.btIcon
        color: Theme.colFg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        opacity: NetworkService.btConnected ? 1.0 : 0.5
    }
}
