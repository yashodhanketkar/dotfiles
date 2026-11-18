import QtQuick
import QtQuick.Layouts
import "../../singletons"

Rectangle {
    id: root

    color: NotificationService.dnd ? Theme.col14 : Theme.col2
    implicitWidth: contentRow.implicitWidth + 20
    implicitHeight: 30
    radius: 8

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 180
            easing.type: Easing.OutCubic
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                NotificationService.toggleDnd();
            } else if (mouse.button === Qt.MiddleButton) {
                NotificationService.clearAll();
            } else {
                NotificationService.togglePanel();
            }
        }
    }

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: NotificationService.dnd ? "" : ""
            color: NotificationService.dnd ? Theme.col1 : Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
        }

        Text {
            Layout.alignment: Qt.AlignVCenter
            visible: NotificationService.count > 0 && !NotificationService.dnd
            text: NotificationService.count
            color: Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
        }
    }
}
