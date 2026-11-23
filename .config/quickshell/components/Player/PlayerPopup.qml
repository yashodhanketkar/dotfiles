import Quickshell
import QtQuick
import "../../singletons/"

PopupWindow {
    id: root

    required property Item target
    property real padding: 2 * Theme.radius
    property real minWidth: 250
    property real maxWidth: 340
    property bool toggled: false

    signal closeRequested

    visible: toggled
    color: "transparent"

    implicitWidth: playerContainer.implicitWidth
    implicitHeight: playerContainer.implicitHeight

    onToggledChanged: {
        if (toggled) {
            autoCloseTimer.interval = 3000;
            autoCloseTimer.restart();
        } else {
            autoCloseTimer.stop();
        }
    }

    Timer {
        id: autoCloseTimer
        repeat: false
        onTriggered: {
            if (!popupHover.hovered) {
                root.closeRequested();
            }
        }
    }

    anchor {
        item: root.target
        edges: Edges.Right
        gravity: Edges.Right
        rect.x: 5 * Theme.radius
        rect.y: 5 * Theme.radius
    }

    Rectangle {
        id: playerContainer
        anchors.fill: parent
        color: Theme.col2
        radius: 10
        border.width: 1
        border.color: Qt.alpha(Theme.col8, 0.15)

        implicitWidth: Math.min(root.maxWidth, Math.max(root.minWidth, mainRow.implicitWidth + (root.padding * 2)))
        implicitHeight: mainRow.implicitHeight + (root.padding * 2)

        HoverHandler {
            id: popupHover
            onHoveredChanged: {
                if (hovered) {
                    autoCloseTimer.stop();
                } else if (root.toggled) {
                    autoCloseTimer.interval = 400;
                    autoCloseTimer.restart();
                }
            }
        }

        PlayerPopupUi {
            id: mainRow
        }
    }
}
