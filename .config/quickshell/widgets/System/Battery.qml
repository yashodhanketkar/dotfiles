import "../../singletons/"
import "../../components/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: batText.implicitWidth + 16
    implicitHeight: Theme.height
    radius: Theme.radius
    color: BatteryStatus.getStatusColor()

    Text {
        id: batText

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: BatteryStatus.charge + "% " + BatteryStatus.icon
        color: Theme.colFg

        font {
            bold: true
            pixelSize: Theme.fontSize
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
        text: BatteryStatus.status
    }
}
