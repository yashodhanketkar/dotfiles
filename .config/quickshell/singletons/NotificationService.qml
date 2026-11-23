pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
    id: root

    property bool dnd: false
    property bool panelOpen: false
    property bool panelHoveredOnce: false
    property int popupTimeout: 2500

    readonly property ObjectModel notifications: server.trackedNotifications
    readonly property int count: notifications.values.length
    readonly property ListModel popups: ListModel {}

    NotificationServer {
        id: server

        bodySupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        imageSupported: true
        inlineReplySupported: true
        persistenceSupported: true
        keepOnReload: true

        onNotification: notification => {
            notification.tracked = true;

            if (root.dnd || root.panelOpen)
                return;

            for (let i = 0; i < root.popups.count; i++) {
                if (root.popups.get(i).notif === notification) {
                    return;
                }
            }

            root.popups.insert(0, {
                notif: notification
            });

            notification.closed.connect(() => {
                root.removePopup(notification);
            });

            console.log(notification);
        }
    }

    function removePopup(notification) {
        for (let i = 0; i < popups.count; i++) {
            if (popups.get(i).notif === notification) {
                popups.remove(i);
                break;
            }
        }
    }

    function clearAll() {
        for (let i = notifications.values.length - 1; i >= 0; i--) {
            notifications.values[i].dismiss();
        }
        popups.clear();
    }

    function setPanelHovered(hovered) {
        if (hovered) {
            root.panelHoveredOnce = true;
            panelCloseTimer.stop();
        } else if (root.panelHoveredOnce) {
            panelCloseTimer.start();
        }
    }

    function togglePanel() {
        root.panelOpen = !root.panelOpen;
        if (root.panelOpen) {
            root.panelHoveredOnce = false;
            panelCloseTimer.stop();
            popups.clear();
        }
    }

    function toggleDnd() {
        root.dnd = !root.dnd;
        if (root.dnd) {
            popups.clear();
        }
    }

    Timer {
        id: panelCloseTimer
        interval: 300
        repeat: false
        onTriggered: root.panelOpen = false
    }

    IpcHandler {
        target: "notifications"

        function togglePanel(): void {
            root.togglePanel();
        }

        function clearAll(): void {
            root.clearAll();
        }

        function toggleDnd(): void {
            root.toggleDnd();
        }
    }
}
