pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../singletons/"

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

            delegate: Rectangle {
                id: toastCard
                required property var notif

                width: popupList.width
                implicitHeight: cardLayout.implicitHeight + 20
                radius: Theme.radius + 2
                color: notif.urgency === 2 ? Theme.colWarn : notif.urgency === 0 ? Qt.alpha(Theme.colFg, 0.5) : Theme.colBg
                border.color: Theme.colBg

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: toastCard.notif.urgency !== 1 ? 4 : 0
                    anchors.margins: parent.border.width
                    radius: parent.radius - 1
                    color: Theme.colBg
                }

                HoverHandler {
                    id: cardHover
                }

                Timer {
                    id: expireTimer
                    interval: NotificationService.popupTimeout
                    running: !cardHover.hovered && !NotificationService.previewMode
                    repeat: false
                    onTriggered: NotificationService.removePopup(toastCard.notif)
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    onClicked: mouse => {
                        if (mouse.button === Qt.RightButton) {
                            toastCard.notif.dismiss();
                        } else {
                            NotificationService.removePopup(toastCard.notif);
                        }
                    }
                }

                ColumnLayout {
                    id: cardLayout
                    anchors.fill: parent
                    anchors.margins: 10
                    anchors.leftMargin: toastCard.notif.urgency !== 1 ? 14 : 10
                    spacing: 4

                    RowLayout {
                        Layout.fillWidth: true

                        Text {
                            text: toastCard.notif.appName || "Notification"
                            color: Theme.colFg

                            opacity: 0.7
                            Layout.fillWidth: true

                            font {
                                family: Theme.fontFamily
                                pixelSize: Theme.fontSmall
                                italic: true
                                bold: true
                            }
                        }

                        Text {
                            text: ""
                            color: Theme.colFg
                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSmall

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: toastCard.notif.dismiss()
                            }
                        }
                    }

                    Text {
                        text: toastCard.notif.summary
                        color: Theme.colFg
                        wrapMode: Text.WordWrap
                        Layout.fillWidth: true
                        font {
                            family: Theme.fontFamily
                            pixelSize: Theme.fontSize
                            bold: true
                        }
                    }

                    Text {
                        visible: toastCard.notif.body !== ""
                        text: toastCard.notif.body
                        color: Theme.col8
                        opacity: 0.85
                        wrapMode: Text.WordWrap
                        maximumLineCount: 4
                        elide: Text.ElideRight
                        Layout.fillWidth: true

                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize - 1
                    }
                }
            }
        }
    }
}
