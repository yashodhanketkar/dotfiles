import "../../singletons"
import "../../components/Calendar/"
import "../../components/"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: root

    property bool calendarOpen: false

    Layout.alignment: Qt.AlignVCenter
    implicitWidth: timeText.implicitWidth + 16
    implicitHeight: 30
    radius: 8
    color: Theme.col2

    Text {
        id: timeText

        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: Icons.iTime + " " + DateTime.time
        color: Theme.colFg

        font {
            pixelSize: Theme.fontSize
            bold: true
            family: Theme.fontFamily
        }
    }

    HoverHandler {
        id: clockHover
        cursorShape: Qt.PointingHandCursor
    }

    TapHandler {
        onTapped: root.calendarOpen = !root.calendarOpen
        acceptedButtons: Qt.RightButton
    }

    Tooltip {
        target: root
        show: clockHover.hovered && !root.calendarOpen
        text: DateTime.datetime
    }

    PopupWindow {
        id: calendarPopup

        anchor {
            item: root
            edges: Edges.Bottom
            gravity: Edges.Bottom
            margins.top: 0
        }

        visible: root.calendarOpen
        implicitWidth: calendar.implicitWidth
        implicitHeight: calendar.implicitHeight
        color: "transparent"

        Calendar {
            id: calendar
        }
    }
}
