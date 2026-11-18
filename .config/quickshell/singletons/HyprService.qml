pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    function getWorkspace(id: int): var {
        return Hyprland.workspaces.values.find(w => w.id === id);
    }

    function isOnMonitor(ws: var, screen: ShellScreen): bool {
        const targetMonitor = Hyprland.monitorFor(screen);
        return Boolean(ws) && ws.monitor?.name === targetMonitor?.name;
    }

    function isActiveOnMonitor(id: int, screen: ShellScreen): bool {
        const targetMonitor = Hyprland.monitorFor(screen);
        return targetMonitor?.activeWorkspace?.id === id;
    }

    function isFocused(ws: var): bool {
        return Boolean(ws) && ws.name === Hyprland.focusedWorkspace?.name;
    }

    function focusWorkspace(id: int): void {
        Quickshell.execDetached(["bash", "-c", "hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = " + id + " }))'"]);
    }
}
