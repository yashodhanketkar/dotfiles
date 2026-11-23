import QtQuick
import "../../singletons/"
import "../../components/Player"

Rectangle {
    id: root

    property color baseColor: "#1DB954"
    property color fontColor: "#191414"
    property bool toggled: false

    color: Qt.alpha(baseColor, PlayerService.status === "Playing" ? 1 : 0.65)
    implicitHeight: Theme.height
    radius: Theme.radius
    implicitWidth: summaryBar.dataWidth + (2 * Theme.radius)

    onVisibleChanged: {
        if (!visible) {
            root.toggled = false;
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.LeftButton:
                PlayerService.playPause();
                break;
            case Qt.RightButton:
                root.toggled = !root.toggled;
                break;
            default:
                console.log("Not available");
            }
        }
    }

    PlayerSummary {
        id: summaryBar
        anchors.centerIn: parent
        fontColor: root.fontColor
    }

    PlayerPopup {
        target: root
        toggled: root.toggled
        onCloseRequested: root.toggled = false
    }
}
