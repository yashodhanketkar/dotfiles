import "../../singletons/"
import "../../utils/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: batText.implicitWidth + 16
    implicitHeight: 30
    radius: 8
    color: BatteryStatus.state === "charging" ? "green" : parseInt(BatteryStatus.charge) < 20 ? "#ee1111" : Theme.col2

    Text {
        id: batText

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: BatteryStatus.charge
        color: Theme.colFg

        font {
            pixelSize: Theme.fontSize
            bold: true
            family: Theme.fontFamily
        }

    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
    }

    Tooltip {
        target: mouseArea.parent
        show: mouseArea.containsMouse
        text: BatteryStatus.state
    }

}
