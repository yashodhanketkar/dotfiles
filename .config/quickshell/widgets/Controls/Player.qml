import "../../singletons/"
import "../../components/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string baseColor: "#1DB954"
    property string fontColor: "#191414"

    color: Qt.alpha(baseColor, PlayerService.status === "Playing" ? 1 : 0.65)

    implicitHeight: Theme.height
    radius: Theme.radius

    property real dataWidth: dataRow.implicitWidth + 2 * Theme.radius
    property real ctrlWidth: spacerRow.implicitWidth + ctrlRow.implicitWidth + 4 * Theme.radius
    implicitWidth: dataWidth + (mouseArea.containsMouse && ctrlWidth)

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    RowLayout {
        id: mediaRow
        anchors.centerIn: parent

        RowLayout {
            id: dataRow
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

        Spacer {
            id: spacerRow
            compact: false
            isVisible: mouseArea.containsMouse
            color: root.fontColor
        }

        RowLayout {
            id: ctrlRow

            visible: mouseArea.containsMouse

            Text {
                id: prevButton
                text: Icons.iMPrev
                color: root.fontColor

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSmall - 2
                }

                MouseArea {
                    id: prevButtonMA
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: () => PlayerService.playPrev()
                }
            }

            Text {
                id: playPause
                text: PlayerService.status === "Playing" ? Icons.iMPlay : Icons.iMPause
                color: root.fontColor

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSmall - 2
                }

                MouseArea {
                    id: pauseButtonMA
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: PlayerService.playPause()
                }
            }

            Text {
                id: nextButton
                text: Icons.iMNext
                color: root.fontColor

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSmall - 2
                }

                MouseArea {
                    id: nextButtonMA
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: () => PlayerService.playNext()
                }
            }
        }
    }

    function getContrastText(bg) {
        const r = bg.r <= 0.03928 ? bg.r / 12.92 : Math.pow((bg.r + 0.055) / 1.055, 2.4);
        const g = bg.g <= 0.03928 ? bg.g / 12.92 : Math.pow((bg.g + 0.055) / 1.055, 2.4);
        const b = bg.b <= 0.03928 ? bg.b / 12.92 : Math.pow((bg.b + 0.055) / 1.055, 2.4);

        const luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
        return luminance > 0.179 ? "#000000" : "#ffffff";
    }
}
