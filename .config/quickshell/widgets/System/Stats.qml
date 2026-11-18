import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../singletons/"
import "../../components/Stats/"

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: summary.implicitWidth + 20
    implicitHeight: 30
    radius: 8
    color: Theme.col2

    SummaryBar {
        id: summary
        anchors.centerIn: parent
    }

    MouseArea {
        id: hoverArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }

    PopupWindow {
        id: statsPopup

        visible: hoverArea.containsMouse
        implicitWidth: 280
        implicitHeight: mainCard.implicitHeight
        color: "transparent"

        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
            rect.y: root.height + 8
        }

        Rectangle {
            id: mainCard

            width: parent.width
            implicitHeight: cardColumn.implicitHeight + 20
            radius: 10
            color: Theme.col2

            ColumnLayout {
                id: cardColumn

                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                CpuAvgSection {}
                CpuFreqSection {}
                MemorySection {}
                DiskSection {}
            }
        }
    }
}
