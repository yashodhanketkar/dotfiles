import "../../../singletons/"
import QtQuick

Text {
    id: root

    anchors.centerIn: parent
    text: [SystemStats.cpuUsage, SystemStats.ramUsage, SystemStats.homeUsage].map(v => {
        return String(v).padStart(2, "0") + "%";
    }).join(" | ")
    color: Theme.col8

    font {
        family: Theme.fontFamily
        pixelSize: Theme.fontSize
        bold: true
    }
}
