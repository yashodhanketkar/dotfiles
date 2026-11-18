import QtQuick
import Quickshell
import "./singletons/"
import "./widgets/"

ShellRoot {
    id: root

    Bar {}
    NotificationsPopup {}
    NotificationPanel {}

    Component.onCompleted: {
        console.log("Notification daemon active, count:", NotificationService.count);
    }
}
