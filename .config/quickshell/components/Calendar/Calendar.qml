import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../singletons/"

PopupWindow {
    id: root

    signal dateActivated(date selecteDate)

    required property Rectangle target

    anchor {
        item: root.target
        edges: Edges.Bottom
        gravity: Edges.Bottom
        margins.top: 0
        rect.y: root.target.height + 8
    }

    implicitWidth: popup.implicitWidth
    implicitHeight: popup.implicitHeight
    color: "transparent"

    Rectangle {
        id: popup

        implicitWidth: Theme.height * 9
        implicitHeight: Theme.height * 9
        radius: Theme.radius
        color: Theme.col2
        border.color: Qt.alpha(Theme.colFg, 0.25)
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.radius * 2
            spacing: 0

            CalendarHeader {}
            CalendarWeekDay {}
            CalendarMonthGrid {
                onDateClicked: (selectDate, localDate) => {
                    console.log(localDate);
                    Quickshell.execDetached(["gnome-calendar", "--date", localDate]);
                    root.dateActivated(selectDate);
                }
            }
        }
    }
}
