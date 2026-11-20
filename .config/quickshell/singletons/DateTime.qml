pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property var currentDate: dateTime.date ?? new Date()
    readonly property string time: Qt.formatDateTime(root.currentDate, "hh:mm")
    readonly property string datetime: Qt.formatDateTime(root.currentDate, "dddd, dd MMMM yyyy, hh:mm:ss")
    readonly property int displayDay: root.currentDate.getDate()

    property int displayYear: root.currentDate.getFullYear()
    property int displayMonth: root.currentDate.getMonth()

    function changeMonth(delta) {
        const next = new Date(root.displayYear, root.displayMonth + delta, 1);
        root.displayYear = next.getFullYear();
        root.displayMonth = next.getMonth();
    }

    function isToday(): bool {
        return root.displayMonth === dateTime.date.getMonth() && root.displayYear === dateTime.date.getFullYear();
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
