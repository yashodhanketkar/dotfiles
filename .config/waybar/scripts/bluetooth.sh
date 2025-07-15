#!/usr/bin/env bash

POWERSTATE=$(bluetoothctl show | grep 'Powered' | awk '{print $2}')
DISCOVERABLESTATE=$(bluetoothctl show | grep 'Discoverable:' | awk '{print $2}')

toggle_power() {
  if [[ $POWERSTATE == "yes" ]]; then
    bluetoothctl power off
  else
    bluetoothctl power on
  fi
}

toggle_discoverable() {
  if [[ $DISCOVERABLESTATE == "yes" ]]; then
    bluetoothctl discoverable off
  else
    bluetoothctl discoverable on
  fi
}

"$@"
