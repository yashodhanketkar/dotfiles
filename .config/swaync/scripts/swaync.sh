#!/usr/bin/env bash

toggle_mute_status() {
  pactl set-sink-mute $(pactl get-default-sink) toggle
}

get_mute_status() {
  current_status=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  if [[ $current_status == "yes" ]]; then
    echo "false"
  else
    echo "true"
  fi
}

toggle_wifi_status() {
  current_status=$(nmcli radio wifi)
  if [[ $current_status == "enabled" ]]; then
    nmcli radio wifi off
  else
    nmcli radio wifi on
  fi
}

get_wifi_status() {
  current_status=$(nmcli radio wifi)
  if [[ $current_status == "enabled" ]]; then
    echo "true"
  else
    echo "false"
  fi
}

"$@"
