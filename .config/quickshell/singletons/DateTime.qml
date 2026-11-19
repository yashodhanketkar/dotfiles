pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property var currentDate: dateTime.date ?? new Date()
    readonly property string time: Qt.formatDateTime(dateTime.date, "hh:mm")
    readonly property string datetime: Qt.formatDateTime(dateTime.date, "dddd, dd MMMM yyyy, hh:mm:ss")

    property int displayYear: dateTime.date.getFullYear()
    property int displayMonth: dateTime.date.getMonth()
    readonly property int displayDay: dateTime.date.getDate()

    function changeMonth(delta) {
        let newMonth = root.displayMonth + delta;
        if (newMonth < 0) {
            root.displayMonth = 11;
            root.displayYear -= 1;
        } else if (newMonth > 11) {
            root.displayMonth = 0;
            root.displayYear += 1;
        } else {
            root.displayMonth = newMonth;
        }
    }

    function isToday(): bool {
        if (root.displayMonth !== dateTime.date.getMonth())
            return false;

        if (root.displayYear !== dateTime.date.getFullYear())
            return false;

        return true;
    }

    function setToday() {
        root.displayMonth = dateTime.date.getMonth();
        root.displayYear = dateTime.date.getFullYear();
    }

    SystemClock {
        id: dateTime

        precision: SystemClock.Seconds
    }
}
