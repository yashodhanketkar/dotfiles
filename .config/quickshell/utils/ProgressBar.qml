import "../singletons/"
import QtQuick

Rectangle {
    id: bar

    property real value: 0
    property color fillColor: Theme.col8
    property color trackColor: Theme.col1

    implicitHeight: 6
    radius: height / 2
    color: trackColor

    Rectangle {
        height: parent.height
        width: Math.max(0, Math.min(parent.width, parent.width * (bar.value / 100)))
        radius: height / 2
        color: bar.fillColor

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }

        }

    }

}
