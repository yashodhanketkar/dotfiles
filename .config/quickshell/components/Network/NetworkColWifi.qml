import "../../singletons/"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    Layout.fillWidth: true
    spacing: 4

    RowLayout {
        Layout.fillWidth: true
        spacing: 6

        Text {
            text: NetworkService.wifiIcon + " " + NetworkService.wifiSsid
            color: Theme.colFg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        Text {
            text: NetworkService.wifiSignal + "%"
            color: Theme.colFg
            opacity: 0.75
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 1
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Text {
            text: NetworkService.wifiIp
            color: Theme.colFg
            opacity: 0.65
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 2
        }

        Item {
            Layout.fillWidth: true
        }

        Text {
            text: NetworkService.wifiSpeed
            color: Theme.colFg
            opacity: 0.65
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 2
        }
    }
}
