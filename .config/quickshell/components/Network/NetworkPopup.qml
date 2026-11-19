import "../../singletons/"
import QtQuick
import QtQuick.Layouts
import Quickshell

PopupWindow {
    id: netPopup

    required property Item target
    property string text: ""
    property bool show: false

    visible: show
    implicitWidth: cardContainer.implicitWidth
    implicitHeight: cardContainer.implicitHeight + 6
    color: "transparent"

    anchor {
        item: target
        edges: Edges.Bottom
        gravity: Edges.Bottom
    }

    Item {
        id: cardContainer
        anchors.fill: parent
        implicitWidth: Math.max(220, mainLayout.implicitWidth + 28)
        implicitHeight: mainLayout.implicitHeight + 24

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 6
            radius: 10
            color: Theme.col2
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.08)

            ColumnLayout {
                id: mainLayout
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                NetworkColWifi {}

                Rectangle {
                    visible: NetworkService.btConnected
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: Theme.colFg
                    opacity: 0.12
                }

                NetworkColBt {}
            }
        }
    }
}
