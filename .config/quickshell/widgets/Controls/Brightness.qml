import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../../components/"

Rectangle {
    id: root

    readonly property bool expanded: hoverHandler.hovered || slider.pressed

    color: Theme.col2
    implicitWidth: expanded ? 160 : (iconText.implicitWidth + levelText.implicitWidth + 28)
    implicitHeight: Theme.height
    radius: Theme.radius
    clip: true

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
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 8

        Text {
            id: iconText

            text: BrightnessService.nightMode ? "" : ""
            color: Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSmall

            MouseArea {
                id: iconMouseArea

                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
            }

            TapHandler {
                id: tapHandler
                acceptedButtons: Qt.RightButton
                onTapped: BrightnessService.toggleNightMode()
            }
        }

        Text {
            id: levelText

            visible: !root.expanded
            text: BrightnessService.brightness
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

    Tooltip {
        target: iconMouseArea.parent
        text: "Right click to turn " + (BrightnessService.nightMode ? "off" : "on") + " night mode"
        show: iconMouseArea.containsMouse
    }
}
