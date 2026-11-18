import QtQuick
import QtQuick.Layouts
import "../../../singletons/"
import "../../../components/"

Rectangle {
    Layout.fillWidth: true
    implicitHeight: diskCol.implicitHeight + 16
    radius: 8
    color: "transparent"
    border.color: Theme.col7
    border.width: 1

    ColumnLayout {
        id: diskCol

        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            Text {
                text: "HOME: " + SystemStats.homePercent.toFixed(2) + "% (" + SystemStats.homeUsed + "/" + SystemStats.homeTotal + ")"
                color: Theme.colFg

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSize - 1
                    bold: true
                }
            }

            ProgressBar {
                Layout.fillWidth: true
                value: SystemStats.homePercent
                fillColor: Theme.col7
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6

            Text {
                text: "BOOT: " + SystemStats.bootPercent.toFixed(2) + "% (" + SystemStats.bootUsed + "/" + SystemStats.bootTotal + ")"
                color: Theme.colFg

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSize - 1
                    bold: true
                }
            }

            ProgressBar {
                Layout.fillWidth: true
                value: SystemStats.bootPercent
                fillColor: Theme.col7
            }
        }
    }
}
