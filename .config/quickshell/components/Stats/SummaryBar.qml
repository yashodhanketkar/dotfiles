import "../../singletons/"
import "../"
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    implicitWidth: statsRow.implicitWidth
    implicitHeight: Theme.height
    color: "transparent"

    component StatText: Text {
        color: Theme.colFg

        font {
            bold: true
            pixelSize: Theme.fontSize
            family: Theme.fontFamily
        }
    }

    RowLayout {
        id: statsRow
        anchors.centerIn: parent
        spacing: 0

        Repeater {
            model: [SystemStats.cpuUsage, SystemStats.ramUsage, SystemStats.homeUsage,]

            RowLayout {
                required property int index
                required property real modelData

                spacing: 0

                StatText {
                    text: String(parent.modelData).padStart(2, "0") + "%"
                }

                Spacer {
                    isVisible: parent.index < 2
                    compact: false
                }
            }
        }
    }
}
