pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    function run(cmd: list<string>): void {
        Quickshell.execDetached(cmd);
    }

    function lockPc(): void {
        run(["hyprlock"]);
    }

    function nightMode(): void {
        run(["louarch", "osmode", "night"]);
    }

    function bluetooth(): void {
        const action = NetworkService.btConnected ? "disconnect" : "connect";
        run(["louarch", "bluetooth", action]);
    }

    function wifi(): void {
        const action = NetworkService.wifiConnected ? "disconnect" : "connect";
        run(["louarch", "wifi", action]);
    }

    function exit() {
        run(["wlogout"]);
    }
}
