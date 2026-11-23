import QtQuick
import QtQuick.Layouts
import "../../singletons/"

Item {
    id: root

    readonly property real desiredWidth: levelText.implicitWidth

    implicitWidth: desiredWidth
    implicitHeight: parent ? parent.height : Theme.height

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 8

        Text {
            id: levelText

            text: BrightnessService.kdbBacklit ? Icons.iKeyboardLit : Icons.iKeyboard
            color: Theme.col8
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                onClicked: () => BrightnessService.setKbdBacklit()
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }
}
