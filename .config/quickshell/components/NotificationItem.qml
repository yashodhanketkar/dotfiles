pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../singletons/"

Rectangle {
    id: card

    required property var notification
    property bool compact: false
    property bool expanded: false
    property color cardColor: Theme.colBg

    signal clicked
    signal rightClicked

    implicitHeight: cardCol.implicitHeight + 18
    radius: 10
    color: card.notification.urgency === 2 ? "red" : card.cardColor
    border.color: Qt.alpha(Theme.colFg, 0.1)
    border.width: 1

    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: card.notification.urgency === 2 ? 4 : 0
        anchors.margins: parent.border.width
        radius: parent.radius - 1
        color: card.cardColor
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                card.rightClicked();
            } else {
                card.clicked();
            }
        }
    }

    ColumnLayout {
        id: cardCol
        anchors.fill: parent
        anchors.margins: 9
        anchors.leftMargin: card.notification.urgency === 2 ? 13 : 9
        spacing: 4

        RowLayout {
            Layout.fillWidth: true

            Text {
                text: card.notification.appName || "Notification"
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
                    onClicked: card.notification.dismiss()
                }
            }
        }

        Text {
            text: card.notification.summary
            color: Theme.colFg
            wrapMode: Text.Wrap
            maximumLineCount: card.compact ? 2 : 0
            elide: card.compact ? Text.ElideRight : Text.ElideNone
            Layout.fillWidth: true

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }
        }

        Text {
            visible: card.notification.body !== ""
            text: card.notification.body
            color: Theme.colFg
            opacity: 0.85
            wrapMode: Text.Wrap
            maximumLineCount: (card.compact || !card.expanded) ? 4 : 0
            elide: (card.compact || !card.expanded) ? Text.ElideRight : Text.ElideNone
            Layout.fillWidth: true

            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 1
        }
    }
}
