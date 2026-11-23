import QtQuick
import QtQuick.Layouts
import "../../singletons/"

RowLayout {
    id: root

    required property color fontColor

    readonly property real dataWidth: dataRow.implicitWidth
    readonly property real ctrlWidth: 0

    RowLayout {
        id: dataRow

        Text {
            id: playerIcon
            text: PlayerService.status === "Playing" ? Icons.iMPlay : Icons.iMPause
            color: root.fontColor

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }
        }

        Text {
            id: playerTitle
            text: PlayerService.shortTitle
            color: root.fontColor

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }
        }

        Text {
            id: artistTitle
            text: PlayerService.shortArtist
            color: root.fontColor

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSmall
                italic: true
            }
        }
    }
}
