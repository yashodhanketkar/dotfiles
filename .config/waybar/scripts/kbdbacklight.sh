#!/usr/bin/env bash

get()
{
  CURRENT=$(brightnessctl --device="platform::kbd_backlight" get)

  if [ $CURRENT -gt 0 ]; then
    STATE="ON"
    CLASS="on"
    TOOLTIP="off"
  else
    STATE="OFF"
    CLASS="off"
    TOOLTIP="on"
  fi

  printf "{ \"text\": \"$STATE\", \"tooltip\": \"Click to turn $TOOLTIP\", \"percentage\": 100, \"class\": \"$CLASS\" }\n"
}


set()
{
  CURRENT=$(brightnessctl --device="platform::kbd_backlight" get)

  if [ $CURRENT -gt 0 ]; then
    brightnessctl --device="platform::kbd_backlight" set 0
  else
    brightnessctl --device="platform::kbd_backlight" set 1
  fi

  pkill -SIGRTMIN+8 waybar
}

"$@"
