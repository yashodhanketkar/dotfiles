import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../singletons/"

DayOfWeekRow {
    Layout.fillWidth: true
    locale: Qt.locale()

    delegate: Text {
        text: shortName
        color: Theme.colFg
        opacity: 1
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize - 2
            bold: true
            underline: true
        }
    }
}
