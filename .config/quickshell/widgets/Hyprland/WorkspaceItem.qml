import "../../singletons"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: wsPill

    required property int index
    readonly property var ws: Hyprland.workspaces.values.find((w) => {
        return w.id === index + 1;
    })
    readonly property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

    visible: Boolean(ws)
    Layout.fillHeight: true
    implicitWidth: Math.max(28, wsText.implicitWidth + 16)
    radius: 8
    color: isActive ? Theme.colCursor : Theme.col2

    Text {
        id: wsText

        anchors.centerIn: parent
        text: wsPill.index + 1
        color: wsPill.isActive ? Theme.col2 : Theme.colCursor

        font {
            pixelSize: Theme.fontSize
            bold: true
            family: Theme.fontFamily
        }

    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            Quickshell.execDetached(["bash", "-c", "hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = " + (wsPill.index + 1) + " }))'"]);
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: 150
        }

    }

}
