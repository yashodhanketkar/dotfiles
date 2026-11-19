import "../../singletons"
import "../../components/Network/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: netRow.implicitWidth + (Theme.radius * 2)
    implicitHeight: Theme.height
    radius: Theme.radius
    color: Theme.col2

    NetworkCore {
        id: netRow
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent
    }

    NetworkPopup {
        target: root
        show: mouseArea.containsMouse
    }
}
