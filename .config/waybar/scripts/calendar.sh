#!/usr/bin/env bash

toggle_calendar() {
    FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')
    eww open --toggle calendar_popup --screen $FOCUSED_MONITOR
}

"$@"
