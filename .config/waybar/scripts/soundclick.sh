#!/usr/bin/env bash

toggle() {
# toggle default sink mute status
wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# gets current sink mute status
STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')

# if sink is muted pause the player otherwise send play command
# regardless of player is found or not
if [[ $STATUS == *'no'* ]]; then
	playerctl play
else
	playerctl pause
fi
}

toggle
