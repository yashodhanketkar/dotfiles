import QtQuick
import QtQuick.Layouts
import "../../singletons/"

RowLayout {
    id: headerRow
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
        implicitWidth: dndLabel.implicitWidth + 16
        implicitHeight: 28
        radius: 6
        color: NotificationService.dnd ? Theme.colWarn : Theme.colCursor

        Text {
            id: dndLabel
            anchors.centerIn: parent
            text: (NotificationService.dnd ? Icons.iBellDND : Icons.iBell) + " DND"
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
