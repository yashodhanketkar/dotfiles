#!/usr/bin/env bash

sys_info() {
    # get cpu usage in percent
    CPU_USAGE=$(LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

    # get memory usage in percent
    RAM_USAGE=$(free -m | awk '/Mem:/ { printf("%3.1f%%", $3 / $2 * 100) }' | sed 's/%//g')

    # get disk space usage in percent
    DISK_USAGE=$(df -h | grep '/dev/sda2' | awk '{ print $5 }' | sed 's/%//g')

    # set variables for the state and tooltip (using printf to format the output)
    STATE=$(printf " %02.0f |  %02.0f |  %02.0f" $CPU_USAGE $RAM_USAGE $DISK_USAGE)
    TOOLTIP=$(printf "CPU: %02.0f RAM: %02.0f DISK: %02.0f" $CPU_USAGE $RAM_USAGE $DISK_USAGE)

    printf "{ \"text\": \"$STATE\", \"tooltip\": \"$TOOLTIP\" }\n"
}

eww_info() {
    FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused).name')
    eww open --toggle sysinfo_popup --screen $FOCUSED_MONITOR
}

"$@"
