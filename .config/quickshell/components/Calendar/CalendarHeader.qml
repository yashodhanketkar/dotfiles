import QtQuick
import QtQuick.Layouts
import "../../singletons/"

RowLayout {
    Layout.fillWidth: true
    spacing: 0

    TextMetrics {
        id: monthYearMetrics
        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize + 1
            bold: true
        }
        text: "September 2026"
    }

    Text {
        text: new Date(DateTime.displayYear, DateTime.displayMonth, 1).toLocaleDateString(Qt.locale(), "MMMM yyyy")
        color: Theme.colFg

        Layout.preferredWidth: monthYearMetrics.advanceWidth
        Layout.minimumWidth: monthYearMetrics.advanceWidth
        Layout.maximumWidth: monthYearMetrics.advanceWidth

        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSize + 1
            bold: true
        }
    }

    Item {
        Layout.fillWidth: true
    }

    Text {
        text: "‹"
        color: Theme.colFg
        font.pixelSize: Theme.fontSize
        leftPadding: 8
        rightPadding: 6

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: DateTime.changeMonth(-1)
        }
    }

    Text {
        text: "Today"
        color: !DateTime.isToday() ? Theme.colFg : Qt.alpha(Theme.colFg, 0.65)

        font {
            family: Theme.fontFamily
            pixelSize: Theme.fontSmall
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: !DateTime.isToday() ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: if (!DateTime.isToday())
                DateTime.setToday()
        }
    }

    Text {
        text: "›"
        color: Theme.colFg
        font.pixelSize: Theme.fontSize
        leftPadding: 8
        rightPadding: 6

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: DateTime.changeMonth(1)
        }
    }
}
