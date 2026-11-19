import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../../components/"

Rectangle {
    id: root

    readonly property bool expanded: hoverHandler.hovered || slider.pressed

    color: VolumeService.muted ? Theme.col14 : Theme.col2
    implicitWidth: expanded ? 160 : (iconText.implicitWidth + levelText.implicitWidth + 28)
    implicitHeight: 30
    radius: 8
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

            text: {
                if (VolumeService.muted || VolumeService.volume === 0)
                    return Icons.iMute;
                if (VolumeService.deviceType === "headphone" || VolumeService.deviceType === "headset")
                    return Icons.iHeadphones;
                if (VolumeService.deviceType === "bluetooth")
                    return Icons.iBTSound;
                if (VolumeService.deviceType === "monitor")
                    return Icons.iMonitorSpeaker;
                return "";
            }
            color: VolumeService.muted ? Theme.col1 : Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize

            MouseArea {
                id: iconMouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                id: tapHandler
                acceptedButtons: Qt.RightButton
                onTapped: VolumeService.toggleMute()
            }
        }

        Text {
            id: levelText
            visible: !root.expanded
            text: Math.round(VolumeService.volume * 100)
            color: Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        ProgressBar {
            id: slider
            visible: root.expanded
            Layout.fillWidth: true
            interactive: true

            fillColor: VolumeService.muted ? Theme.colWarn : Theme.col8
            trackColor: Theme.colBg
            value: VolumeService.volume * 100
            onMoved: newValue => VolumeService.setVolume(newValue / 100)

            MouseArea {
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    Tooltip {
        target: iconMouseArea.parent
        text: "Right click to " + (VolumeService.muted ? "unmute" : "mute")
        show: iconMouseArea.containsMouse
    }
}
