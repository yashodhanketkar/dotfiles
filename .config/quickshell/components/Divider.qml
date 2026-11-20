import "../singletons/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    property bool isVisible: true
    property bool compact: true

    visible: visible
    Layout.preferredHeight: 1
    Layout.fillWidth: true

    Layout.topMargin: compact ? 0 : Theme.radius
    Layout.bottomMargin: compact ? 0 : Theme.radius

    color: Theme.colFg
}
