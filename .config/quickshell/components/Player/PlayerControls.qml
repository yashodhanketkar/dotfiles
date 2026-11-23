import QtQuick
import QtQuick.Layouts
import "../../singletons/"

RowLayout {
    id: root
    required property color fontColor
    property int iconSize
    property bool compact: true

    spacing: compact ? 0 : (2 * Theme.radius)

    component PlayerButton: Text {
        id: pButton
        signal valueModified

        property string icon: Icons.iClose
        property int iconSize: Theme.fontSmall - 2

        text: icon

        font {
            family: Theme.fontFamily
            pixelSize: pButton.iconSize
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: pButton.valueModified()
        }
    }

    PlayerButton {
        icon: Icons.iMPrev
        color: root.fontColor
        onValueModified: PlayerService.playPrev()
        iconSize: root.iconSize
    }

    PlayerButton {
        icon: PlayerService.status === "Playing" ? Icons.iMPlay : Icons.iMPause
        color: root.fontColor
        onValueModified: PlayerService.playPause()
        iconSize: root.iconSize
    }

    PlayerButton {
        icon: Icons.iMNext
        color: root.fontColor
        onValueModified: PlayerService.playNext()
        iconSize: root.iconSize
    }
}
