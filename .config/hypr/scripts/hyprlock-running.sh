#!/usr/bin/env bash

ART_FILE="/tmp/mpriscurr"
LAST_URL=""

PCCMD="playerctl --ignore-player firefox"

update_art() {
    if ! $PCCMD status >/dev/null 2>&1; then
        echo "No player running. Clearing art."
        rm -f "$ART_FILE"
        LAST_URL=""
        pkill -SIGUSR2 hyprlock
        return
    fi

    local art_url
    art_url=$($PCCMD metadata --format "{{ mpris:artUrl }}" 2>/dev/null)

    if [[ -n "$art_url" && "$art_url" != "$LAST_URL" ]]; then
        echo "New track detected. Downloading art."
        curl -sL "$art_url" -o "$ART_FILE"
        LAST_URL="$art_url"
        pkill -SIGUSR2 hyprlock
    fi
}

update_art

while true; do
    $PCCMD -F metadata --format "{{ status }} {{ xesam:title }}" 2>/dev/null | while read -r _; do
        update_art
    done

    update_art
    sleep 2
done
