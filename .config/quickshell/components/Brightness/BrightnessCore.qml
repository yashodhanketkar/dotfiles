import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../"

RowLayout {
    id: root

    readonly property alias iconItem: iconMouseArea
    readonly property alias iconHovered: iconMouseArea.containsMouse

    readonly property real desiredWidth: implicitWidth + 20

    anchors.fill: parent
    anchors.leftMargin: 10
    anchors.rightMargin: 10
    spacing: 8

    Text {
        id: iconText

        text: BrightnessService.nightMode ? Icons.iMoon : Icons.iSun
        color: Theme.col8
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSmall

        MouseArea {
            id: iconMouseArea

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                if (mouse.button === Qt.RightButton) {
                    BrightnessService.toggleNightMode();
                }
            }
        }
    }

    Spacer {
        isVisible: BrightnessService.hasExternalMonitor
    }

    BrightnessInternal {
        id: inter
        Layout.fillHeight: true
    }

    Spacer {
        isVisible: BrightnessService.hasExternalMonitor
    }

    BrightnessExternal {
        id: exter
        visible: BrightnessService.hasExternalMonitor
        Layout.fillHeight: true
    }

    Spacer {
        isVisible: true
    }

    BrightnessKbd {
        id: kbd
        Layout.fillHeight: true
    }
}
