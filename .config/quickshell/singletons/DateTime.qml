import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    readonly property string time: Qt.formatDateTime(dateTime.date, "hh:mm")
    readonly property string datetime: Qt.formatDateTime(dateTime.date, "dddd dd-MMMM-yyyy hh:mm:ss")

    SystemClock {
        id: dateTime

        precision: SystemClock.Seconds
    }

}
