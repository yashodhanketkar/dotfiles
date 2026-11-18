import "../singletons"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: root

    required property int index
    required property ShellScreen screen

    readonly property int wsId: index + 1
    readonly property var ws: HyprService.getWorkspace(wsId)
    readonly property bool isFocused: HyprService.isFocused(ws)

    visible: HyprService.isOnMonitor(ws, screen)
    Layout.fillHeight: true
    implicitWidth: Math.max(28, wsText.implicitWidth + 16)
    radius: 8
    color: isFocused ? Theme.colCursor : Theme.col2

    Text {
        id: wsText

        anchors.centerIn: parent
        text: root.wsId
        color: root.isFocused ? Theme.col2 : Theme.colCursor

        font {
            pixelSize: Theme.fontSize
            bold: true
            family: Theme.fontFamily
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: HyprService.focusWorkspace(root.wsId)
    }

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }
}
