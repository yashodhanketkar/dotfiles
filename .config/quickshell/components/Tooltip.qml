import "../singletons/"
import QtQuick
import Quickshell

PopupWindow {
    id: root

    required property Item target
    property string text: ""
    property bool show: false

    visible: root.show && root.target.visible
    implicitWidth: Math.ceil(metrics.width) + 16
    implicitHeight: Math.ceil(metrics.height) + 10
    color: "transparent"

    anchor {
        item: root.target
        edges: Edges.Bottom
        gravity: Edges.Bottom
        rect.y: root.target.height + 6
    }

    TextMetrics {
        id: metrics

        font: tooltipText.font
        text: root.text
    }

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: Theme.col2

        Text {
            id: tooltipText

            anchors.centerIn: parent
            text: root.text
            color: Theme.col8

            font {
                pixelSize: Theme.fontSize - 1
                bold: true
                family: Theme.fontFamily
            }
        }
    }
}
