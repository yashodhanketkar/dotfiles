import QtQuick
import "../singletons/"

Rectangle {
    id: root

    required property string lableMessage
    property bool closeOnClick: false

    signal clickedSignal

    implicitWidth: (360 / 2) - (2 * Theme.radius)
    implicitHeight: Theme.height - 2
    radius: Theme.radius - 2
    color: Theme.colCursor

    Text {
        id: lableText
        anchors.centerIn: parent
        text: root.lableMessage
        color: Theme.colBg
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize - 1
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.clickedSignal();
            if (root.closeOnClick)
                NotificationService.panelOpen = false;
        }
    }
}
