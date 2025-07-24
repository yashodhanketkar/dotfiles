#!/usr/bin/env bash

get_weather() {
  # curl -s 'wttr.in?format=%c+%C+%t\n%l'
  echo $(jq -r '"   "+.temperature+"°C ("+.feels_like+"°C)"' /tmp/weather.json)
  echo $(jq -r '"   "+.humidity+"%"' /tmp/weather.json)
  echo $(jq -r '"   "+.pressure+" mb"' /tmp/weather.json)
  echo $(jq -r '"   "+.description' /tmp/weather.json)
  echo $(jq -r '"   "+.location' /tmp/weather.json)
}

get_battery() {
  # battery info command shorthand
  BAT_INFO=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)

  # get state
  STATE=$(echo "$BAT_INFO" | grep 'state' | awk '{ print $2 }')

  # show fully charged with 'plug-circle-check'
  if [[ "$STATE" == "fully-charged" ]]; then
    echo "FULLY CHARGED"
    exit 0
  fi

  # get current battery percentage/level
  POWERLEVEL=$(echo "$BAT_INFO" | grep 'percentage' | awk '{ print $2 }' | tr -d '%')

  # show fully charged with 'plug-circle-bolt'
  if [[ "$STATE" == "charging" ]]; then
    echo " + $POWERLEVEL%"
    exit 0
  fi

  # set icon as per powerlevel
  case $POWERLEVEL in
    9[0-9]|100) ICON=""
      ;;
    8[0-9]|7[0-9]) ICON=""
      ;;
    6[0-9]|5[0-9]) ICON=""
      ;;
    4[0-9]|3[0-9]) ICON=""
      ;;
    *) ICON=""
      ;;
  esac

  echo "$ICON $POWERLEVEL%"
}

get_music() {
  # playerctl base command
  # ignores firefox media
  PCCMD="playerctl --ignore-player firefox"

  if ! playerctl status &> /dev/null; then
    echo ""
    exit 0
  fi

  TITLE=$($PCCMD metadata --format '{{title}}')
  ARTIST=$($PCCMD metadata --format '{{artist}}')
  TIME=$($PCCMD metadata --format "{{ duration(position) }} / {{ duration(mpris:length) }} (-{{ duration(mpris:length - position) }})")
  STATUS_TEXT=$($PCCMD status)

  case $STATUS_TEXT in
    Playing) STATUS=""
      ;;
    Paused) STATUS=""
      ;;
    *) STATUS=""
      ;;
  esac

  echo $TITLE
  echo $ARTIST
  echo $STATUS $TIME
}

sys_info() {
  # get cpu usage in percent
  CPU_USAGE=$(LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

  # get memory usage in percent
  RAM_USAGE=$(free -m | awk '/Mem:/ { printf("%3.1f%%", $3 / $2 * 100) }')

  # get disk space usage in percent
  DISK_USAGE=$(df -h | grep '/dev/sda2' | awk '{ print $5 }')

  echo CPU: $CPU_USAGE
  echo RAM: $RAM_USAGE
  echo DISK: $DISK_USAGE
}

clipboard() {
  cliphist list | wofi --dmenu | cliphist decode | wl-copy
}

"$@"
