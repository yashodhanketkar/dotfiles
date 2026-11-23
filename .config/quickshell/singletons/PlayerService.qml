pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string ignoredPlayers: "firefox,chromium,chrome,brave"

    property string activePlayerName: ""
    property string status: "Stopped"
    property string title: ""
    property string artist: ""
    property string album: ""
    property string artUrl: ""

    readonly property bool hasPlayer: activePlayerName !== ""
    readonly property string shortTitle: truncate(title, 15)
    readonly property string shortArtist: truncate(artist, 10)

    function playNext() {
        if (!hasPlayer)
            return;
        runControl(["playerctl", "-p", activePlayerName, "next"]);
    }

    function playPrev() {
        if (!hasPlayer)
            return;
        runControl(["playerctl", "-p", activePlayerName, "previous"]);
    }

    function playPause() {
        if (!hasPlayer)
            return;
        runControl(["playerctl", "-p", activePlayerName, "play-pause"]);
    }

    function runControl(cmd) {
        playerCtrlProc.command = cmd;
        playerCtrlProc.running = true;
        quickRefreshTimer.restart();
    }

    function truncate(str, maxLen) {
        if (!str)
            return "";
        return str.length > maxLen ? str.slice(0, maxLen) + "…" : str;
    }

    function resetState() {
        activePlayerName = "";
        status = "Stopped";
        title = "";
        artist = "";
        album = "";
        artUrl = "";
    }

    Process {
        id: playerCtrlProc
    }

    Process {
        id: playerFetchProc
        command: ["playerctl", "--ignore-player=" + root.ignoredPlayers, "metadata", "--format", "{{playerName}}|||{{status}}|||{{title}}|||{{artist}}|||{{album}}|||{{mpris:artUrl}}"]

        stdout: StdioCollector {
            onStreamFinished: {
                const raw = text.trim();
                if (!raw) {
                    root.resetState();
                    return;
                }

                const parts = raw.split("|||");
                if (parts.length < 6) {
                    root.resetState();
                    return;
                }

                root.activePlayerName = parts[0] || "";
                root.status = parts[1] || "Stopped";

                let rawTitle = parts[2] || "Unknown Title";
                let rawArtist = parts[3] || "Unknown Artist";
                let rawAlbum = parts[4] || "";

                if (!rawAlbum && rawTitle.includes(" - ")) {
                    const splitTitle = rawTitle.split(" - ");
                    rawArtist = splitTitle[0].trim();
                    rawTitle = splitTitle.slice(1).join(" - ").trim();
                }

                root.title = rawTitle;
                root.artist = rawArtist;
                root.album = rawAlbum;
                root.artUrl = parts[5] || "";
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {
                if (text.includes("No players found") || text.includes("No player could handle")) {
                    root.resetState();
                }
            }
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            if (!playerFetchProc.running) {
                playerFetchProc.running = true;
            }
        }
    }

    Timer {
        id: quickRefreshTimer
        interval: 150
        repeat: false
        onTriggered: {
            if (!playerFetchProc.running) {
                playerFetchProc.running = true;
            }
        }
    }
}
