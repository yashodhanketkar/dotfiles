pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../singletons"

PanelWindow {
    id: panelWindow

    visible: NotificationService.panelOpen

    anchors {
        top: true
        right: true
        bottom: true
    }

    margins {
        top: 42
        right: 12
        bottom: 12
    }

    implicitWidth: 360
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    Rectangle {
        id: panelContainer

        anchors.fill: parent
        radius: 12
        color: Qt.alpha(Theme.colBg, 0.75)
        border.color: Qt.alpha(Theme.colBg, 0.75)
        border.width: 1

        property bool hasBeenHovered: true

        HoverHandler {
            onHoveredChanged: NotificationService.setPanelHovered(hovered)
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Text {
                    text: "Notifications (" + NotificationService.count + ")"
                    color: Theme.colFg
                    Layout.fillWidth: true

                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSize + 2
                    font.bold: true
                }

                Rectangle {
                    implicitWidth: dndLable.implicitWidth + 16
                    implicitHeight: 28
                    radius: 6
                    color: NotificationService.dnd ? Theme.colWarn : Theme.colCursor

                    Text {
                        id: dndLable
                        anchors.centerIn: parent
                        text: (NotificationService.dnd ? "" : "") + " DND"
                        color: NotificationService.dnd ? Theme.colFg : Theme.colBg
                        font.family: "JetBrains Mono"
                        font.pixelSize: 13
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: NotificationService.toggleDnd()
                    }
                }

                Rectangle {
                    visible: NotificationService.count > 0
                    implicitWidth: clearLabel.implicitWidth + 16
                    implicitHeight: 28
                    radius: 6
                    color: Theme.colCursor

                    Text {
                        id: clearLabel
                        anchors.centerIn: parent
                        text: "Clear"
                        color: Theme.colBg
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSize - 1
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: NotificationService.clearAll()
                    }
                }
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

                delegate: Rectangle {
                    id: historyCard
                    required property var modelData

                    width: historyList.width
                    implicitHeight: cardCol.implicitHeight + 18
                    radius: 10
                    color: historyCard.modelData.urgency === 2 ? "red" : Theme.colBg
                    border.color: Qt.alpha(Theme.colFg, 0.1)
                    border.width: 1

                    Rectangle {
                        anchors.fill: parent
                        anchors.leftMargin: 4
                        anchors.margins: parent.border.width
                        radius: parent.radius - 2
                        color: Theme.colBg
                    }

                    ColumnLayout {
                        id: cardCol
                        anchors.fill: parent
                        anchors.margins: 9
                        anchors.leftMargin: historyCard.modelData.urgency === 2 ? 13 : 9
                        spacing: 4

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                text: historyCard.modelData.appName || "Notification"
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
                                color: Qt.alpha(Theme.colFg, 0.5)
                                opacity: 0.7

                                font.family: Theme.fontFamily
                                font.pixelSize: Theme.fontSmall

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: historyCard.modelData.dismiss()
                                }
                            }
                        }

                        Text {
                            text: historyCard.modelData.summary
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
                            visible: historyCard.modelData.body !== ""
                            text: historyCard.modelData.body
                            color: Theme.colFg
                            opacity: 0.85
                            wrapMode: Text.WordWrap
                            Layout.fillWidth: true

                            font.family: Theme.fontFamily
                            font.pixelSize: Theme.fontSize - 1
                        }
                    }
                }
            }
        }
    }
}
