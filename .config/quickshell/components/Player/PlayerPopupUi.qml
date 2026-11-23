import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../"

RowLayout {
    id: root

    anchors.fill: parent
    anchors.margins: 2 * Theme.radius
    spacing: 12

    Rectangle {
        Layout.fillHeight: true
        Layout.preferredWidth: 4
        radius: 2
        color: PlayerService.status === "Playing" ? "#1DB954" : Qt.alpha(Theme.col8, 0.3)
    }

    ColumnLayout {
        id: playerColumn
        Layout.fillWidth: true
        spacing: 4

        Text {
            Layout.alignment: Qt.AlignRight
            text: PlayerService.status === "Playing" ? "NOW PLAYING" : "PAUSED"
            color: PlayerService.status === "Playing" ? "#1DB954" : Qt.alpha(Theme.col8, 0.6)
            font {
                family: Theme.fontFamily
                pixelSize: Math.max(9, Theme.fontSize - 4)
                bold: true
                letterSpacing: 1.1
            }
        }

        Text {
            id: titleRow
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
            horizontalAlignment: Text.AlignRight
            elide: Text.ElideRight
            text: PlayerService.title || "Unknown Track"
            color: Theme.col8

            font {
                family: Theme.fontFamily
                bold: true
                pixelSize: Theme.fontSize + 1
            }
        }

        Text {
            id: artistRow
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
            horizontalAlignment: Text.AlignRight
            elide: Text.ElideRight
            text: PlayerService.artist || "Unknown Artist"
            color: Qt.alpha(Theme.col8, 0.75)

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - 1
            }
        }

        Divider {
            visible: true
            color: Theme.col8
            opacity: 0.15
            compact: false
        }

        PlayerControls {
            id: ctrlRow
            Layout.alignment: Qt.AlignRight
            visible: true
            fontColor: Theme.col8
            iconSize: Theme.fontSize + 2
            compact: false
        }
    }
}
