pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../singletons/"
import "../../components/"

PanelWindow {
    id: popupWindow

    visible: NotificationService.popups.count > 0

    anchors {
        top: true
        right: true
    }

    margins {
        top: 42
        right: 12
    }

    implicitWidth: 340
    implicitHeight: popupList.implicitHeight
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    Column {
        id: popupList
        width: parent.width
        spacing: 8

        add: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 180
            }
            NumberAnimation {
                property: "x"
                from: 40
                to: 0
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        move: Transition {
            NumberAnimation {
                properties: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Repeater {
            model: NotificationService.popups

            delegate: NotificationItem {
                id: toastDelegation
                required property var notif

                width: popupList.width
                notification: notif
                compact: true
                cardColor: Qt.alpha(Theme.colBg, 0.9)

                onClicked: NotificationService.removePopup(notif)
                onRightClicked: notif.dismiss()

                HoverHandler {
                    id: cardHover
                }

                Timer {
                    interval: NotificationService.popupTimeout
                    running: !cardHover.hovered
                    repeat: false
                    onTriggered: NotificationService.removePopup(toastDelegation.notif)
                }
            }
        }
    }
}
