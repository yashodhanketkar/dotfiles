import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../"

Item {
    id: root

    readonly property bool expanded: hoverHandler.hovered || slider.pressed
    readonly property real collapsedWidth: levelText.implicitWidth
    readonly property real desiredWidth: expanded ? 140 : collapsedWidth

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
            text: Icons.iLaptop + " " + BrightnessService.brightness
            color: Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        ProgressBar {
            id: slider

            visible: root.expanded
            Layout.fillWidth: true
            interactive: true

            fillColor: Theme.col8
            trackColor: Theme.colBg
            value: BrightnessService.brightness
            onMoved: newValue => BrightnessService.setBrightness(newValue)
        }
    }
}
