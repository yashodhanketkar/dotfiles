import "../singletons/"
import QtQuick

Rectangle {
    id: bar

    property real value: 0
    property bool interactive: false
    property real stepSize: 5
    property color fillColor: Theme.col8
    property color trackColor: Theme.col1

    signal moved(real newValue)
    readonly property alias pressed: mouseArea.pressed

    implicitHeight: 6
    radius: height / 2
    color: trackColor

    Rectangle {
        height: parent.height
        width: Math.max(0, Math.min(parent.width, parent.width * (bar.value / 100)))
        radius: height / 2
        color: bar.fillColor

        Behavior on width {
            enabled: !mouseArea.pressed
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        anchors.topMargin: -6
        anchors.bottomMargin: -6
        enabled: bar.interactive
        cursorShape: bar.interactive ? Qt.PointingHandCursor : Qt.ArrowCursor

        function updateFromX(mouseX) {
            let ratio = Math.max(0, Math.min(1, mouseX / bar.width));
            bar.moved(ratio * 100);
        }

        onPressed: mouse => updateFromX(mouse.x)
        onPositionChanged: mouse => {
            if (pressed)
                updateFromX(mouse.x);
        }
        onWheel: wheel => {
            let delta = wheel.angleDelta.y > 0 ? bar.stepSize : -bar.stepSize;
            bar.moved(Math.max(0, Math.min(100, bar.value + delta)));
        }
    }
}
