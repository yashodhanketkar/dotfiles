import QtQuick
import QtQuick.Layouts
import "../../../singletons/"
import "../../../components/"

Rectangle {
    Layout.fillWidth: true
    implicitHeight: ramCol.implicitHeight + 16
    radius: 8
    color: "transparent"
    border.color: Theme.col7
    border.width: 1

    ColumnLayout {
        id: ramCol

        anchors.fill: parent
        anchors.margins: 8
        spacing: 6

        Text {
            text: "RAM: " + SystemStats.ramPercent.toFixed(2) + "% (" + SystemStats.ramUsedMiB + "MiB / " + SystemStats.ramTotalMiB + "MiB)"
            color: Theme.colFg

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - 1
                bold: true
            }
        }

        ProgressBar {
            Layout.fillWidth: true
            value: SystemStats.ramPercent
            fillColor: Theme.col7
        }
    }
}
