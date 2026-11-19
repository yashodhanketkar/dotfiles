pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../singletons/"

MonthGrid {
    id: root

    signal dateClicked(date selectedDate, string isoDate)

    Layout.fillWidth: true
    Layout.fillHeight: true
    month: DateTime.displayMonth
    year: DateTime.displayYear
    locale: Qt.locale()

    delegate: Rectangle {
        id: monthGridDel

        required property var model
        readonly property bool isCurrentMonth: model.month === DateTime.displayMonth
        readonly property bool isToday: DateTime.isToday() && model.day === DateTime.displayDay

        radius: Theme.radius
        color: isToday ? Theme.colFg : (dayHover.hovered ? Theme.colCursor : "transparent")

        HoverHandler {
            id: dayHover
            cursorShape: Qt.PointingHandCursor
        }

        TapHandler {
            onTapped: {
                const yyyy = parent.model.year;
                const mm = String(parent.model.month + 1).padStart(2, "0");
                const dd = String(parent.model.day).padStart(2, "0");
                const localDate = `${mm}/${dd}/${yyyy}`;

                root.dateClicked(new Date(parent.model.year, parent.model.month, parent.model.day), localDate);
            }
        }

        Text {
            anchors.centerIn: parent
            text: model.day
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize - 1
            font.bold: parent.isCurrentMonth
            font.underline: parent.isToday
            color: parent.isToday ? Theme.colBg : Theme.colFg
            opacity: parent.isCurrentMonth ? 1.0 : 0.35
        }
    }
}
