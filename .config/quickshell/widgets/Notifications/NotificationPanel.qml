pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../singletons/"
import "../../components/"

PanelWindow {
    id: panelWindow

    readonly property int panelWidth: 360
    readonly property int rightGap: 12

    visible: NotificationService.panelOpen || panelContainer.x < panelWindow.implicitWidth
    WlrLayershell.keyboardFocus: NotificationService.panelOpen ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    anchors {
        top: true
        right: true
        bottom: true
    }
    margins {
        top: 42
        right: 0
        bottom: 12
    }

    implicitWidth: panelWidth + rightGap
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        id: panelContainer

        width: panelWindow.panelWidth
        height: parent.height
        radius: 12
        color: Qt.alpha(Theme.colBg, 0.75)
        border.color: Qt.alpha(Theme.colBg, 0.75)
        border.width: 1

        focus: NotificationService.panelOpen

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                NotificationService.panelOpen = false;
                event.accepted = true;
            } else if ((event.modifiers & Qt.ShiftModifier) && event.key === Qt.Key_C) {
                NotificationService.clearAll();
                event.accepted = true;
            } else if ((event.modifiers & Qt.ShiftModifier) && event.key === Qt.Key_D) {
                NotificationService.toggleDnd();
                event.accepted = true;
            }
        }

        x: NotificationService.panelOpen ? 0 : panelWindow.implicitWidth

        Behavior on x {
            NumberAnimation {
                duration: 240
                easing.type: Easing.OutCubic
            }
        }

        HoverHandler {
            onHoveredChanged: NotificationService.setPanelHovered(hovered)
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            NotificationHeader {
                Layout.fillWidth: true
            }

            Item {
                visible: NotificationService.count === 0
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    anchors.centerIn: parent
                    text: NotificationService.dnd ? "Do Not Disturb is on" : "No notifications"
                    color: Theme.colFg
                    opacity: 0.5
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize
                }
            }

            ListView {
                id: historyList
                visible: NotificationService.count > 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 8
                model: NotificationService.notifications

                delegate: NotificationItem {
                    required property var modelData

                    width: historyList.width
                    notification: modelData
                    compact: false
                    cardColor: Theme.colBg

                    onClicked: expanded = !expanded
                }
            }
        }
    }
}
