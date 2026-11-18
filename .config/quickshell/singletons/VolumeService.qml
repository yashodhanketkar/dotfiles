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

    readonly property string description: root.sink?.properties["node.description"] ?? "Unknown Output"

    readonly property string deviceType: {
        const props = root.sink?.properties;
        if (!props)
            return "internal";

        const iconName = (props["device.icon_name"] ?? props["device.icon-name"] ?? "").toLowerCase();
        const formFactor = (props["device.form-factor"] ?? "").toLowerCase();
        const api = (props["device.api"] ?? "").toLowerCase();
        const profileDesc = (props["device.profile.description"] ?? "").toLowerCase();

        if (api === "bluez5" || iconName.includes("bluetooth"))
            return "bluetooth";

        if (formFactor === "headphone" || iconName.includes("headphone") || profileDesc.includes("headphone"))
            return "headphone";
        if (formFactor === "headset" || iconName.includes("headset"))
            return "headset";

        if (iconName.includes("video-display") || profileDesc.includes("hdmi") || profileDesc.includes("displayport"))
            return "monitor";

        if (formFactor === "speaker" || iconName.includes("speaker") || profileDesc.includes("speaker")) {
            return (props["device.bus"] === "pci") ? "internal" : "speaker";
        }

        return "internal";
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
