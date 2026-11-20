import "../singletons/"
import QtQuick
import QtQuick.Layouts

Rectangle {
    property bool isVisible: true
    property bool compact: true

    visible: isVisible

    Layout.preferredWidth: 1
    Layout.preferredHeight: Theme.height * 0.55
    Layout.alignment: Qt.AlignVCenter

    Layout.leftMargin: compact ? 0 : Theme.radius
    Layout.rightMargin: compact ? 0 : Theme.radius

    color: Theme.col8
    opacity: 0.45
}
