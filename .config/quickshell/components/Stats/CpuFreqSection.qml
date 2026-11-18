import QtQuick
import QtQuick.Layouts
import "../../singletons/"

Rectangle {
    id: freqSec
    Layout.fillWidth: true
    implicitHeight: coresCol.implicitHeight + 16
    radius: 8
    color: "transparent"
    border.color: Theme.col7
    border.width: 1

    ColumnLayout {
        id: coresCol

        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        Repeater {
            model: SystemStats.perCoreStats

            RowLayout {
                required property var modelData

                Layout.fillWidth: true

                Text {
                    text: parent.modelData.name + ": " + parent.modelData.usage + "%"
                    color: Theme.colFg

                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize - 1
                        bold: true
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    text: modelData.freq + " MHz"
                    color: Theme.col7

                    font {
                        family: Theme.fontFamily
                        pixelSize: Theme.fontSize - 1
                    }
                }
            }
        }
    }
}
