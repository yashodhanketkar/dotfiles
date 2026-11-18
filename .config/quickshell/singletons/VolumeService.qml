pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [root.sink]
    }

    readonly property real volume: root.sink?.audio?.volume ?? 0.0
    readonly property bool muted: root.sink?.audio?.muted ?? false

    readonly property string deviceType: {
        if (!root.sink)
            return "none";

        const props = root.sink.properties ?? {};
        const api = (props["device.api"] ?? "").toLowerCase();
        const formFactor = (props["device.form-factor"] ?? "").toLowerCase();
        const iconName = (props["device.icon-name"] ?? "").toLowerCase();
        const name = (root.sink.name ?? "").toLowerCase();

        if (api === "bluez5" || name.includes("bluez") || iconName.includes("bluetooth")) {
            return "bluetooth";
        }
        if (formFactor === "headphone" || formFactor === "headset" || iconName.includes("headphone") || iconName.includes("headset")) {
            return "headphones";
        }
        return "speaker";
    }

    function setVolume(newVolume) {
        if (!root.sink?.audio)
            return;
        root.sink.audio.volume = Math.max(0.0, Math.min(1.0, newVolume));
    }

    function toggleMute() {
        if (!root.sink?.audio)
            return;
        root.sink.audio.muted = !root.sink.audio.muted;
    }
}
