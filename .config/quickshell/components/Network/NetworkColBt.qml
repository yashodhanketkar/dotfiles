import "../../singletons/"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    visible: NetworkService.btConnected
    Layout.fillWidth: true
    spacing: 4

    RowLayout {
        Layout.fillWidth: true
        spacing: 6

        Text {
            text: Icons.iBTConnected + " " + NetworkService.btDeviceName
            color: Theme.colFg
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        Text {
            visible: NetworkService.btBattery >= 0
            text: NetworkService.btBattery + "%"
            color: NetworkService.btBattery <= 20 ? "#f38ba8" : Theme.colFg
            opacity: NetworkService.btBattery <= 20 ? 1.0 : 0.75
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 1
            font.bold: NetworkService.btBattery <= 20
        }
    }

    Text {
        text: NetworkService.btDeviceMac
        color: Theme.colFg
        opacity: 0.55
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 2
    }
}
