import QtQuick
import QtQuick.Layouts
import "../../singletons/"
import "../../components/"

Rectangle {
    id: root

    implicitHeight: ctrlRow.implicitHeight
    color: "transparent"

    GridLayout {
        id: ctrlRow
        anchors.fill: parent
        implicitHeight: 30
        columnSpacing: 8
        rowSpacing: 8
        columns: 2

        NotificationButtons {
            visible: true
            lableMessage: "Lock"
            onClickedSignal: () => NotificationControls.lockPc()
            closeOnClick: true
        }

        NotificationButtons {
            visible: true
            lableMessage: "Exit"
            onClickedSignal: () => NotificationControls.exit()
            closeOnClick: true
        }

        NotificationButtons {
            visible: true
            lableMessage: "Bluetooth"
            onClickedSignal: () => NotificationControls.bluetooth()
        }

        NotificationButtons {
            visible: true
            lableMessage: "WiFi"
            onClickedSignal: () => NotificationControls.wifi()
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
