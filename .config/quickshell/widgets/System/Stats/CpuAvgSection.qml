import QtQuick
import QtQuick.Layouts
import "../../../singletons/"
import "../../../components/"

Rectangle {
    id: avgSec

    Layout.fillWidth: true
    implicitHeight: freqCol.implicitHeight + 16
    radius: 8
    color: "transparent"

    border.color: Qt.alpha(Theme.col7, 0.3)
    border.width: 1

    ColumnLayout {
        id: freqCol

        anchors.fill: parent
        anchors.margins: 8
        spacing: 6

        Text {
            text: "AVG FREQ: " + SystemStats.avgFreqMhz.toFixed(1) + " MHz"
            color: Theme.colFg

            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize - 1
                bold: true
            }
        }

        ProgressBar {
            Layout.fillWidth: true
            value: (SystemStats.avgFreqMhz / SystemStats.maxFreqMhz) * 100

            fillColor: Theme.col7
            color: Theme.colBg
        }
    }
}
