import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../"

Item {
    id: root

    property string icon: ""
    property real value: 0
    property real expandedWidth: 140
    property color accentColor: Theme.col8
    property color trackColor: Theme.colBg

    signal valueModified(real newValue)

    readonly property bool expanded: hoverHandler.hovered || slider.pressed
    readonly property real collapsedWidth: levelText.implicitWidth
    readonly property real desiredWidth: expanded ? expandedWidth : collapsedWidth

    implicitWidth: desiredWidth
    implicitHeight: parent ? parent.height : Theme.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    HoverHandler {
        id: hoverHandler
    }

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Text {
            id: levelText

            visible: !root.expanded
            text: (root.icon !== "" ? root.icon + " " : "") + root.value
            color: root.accentColor
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        ProgressBar {
            id: slider

            visible: root.expanded
            Layout.fillWidth: true
            interactive: true

            fillColor: root.accentColor
            trackColor: root.trackColor
            value: root.value

            onMoved: newValue => root.valueModified(newValue)
        }
    }
}
