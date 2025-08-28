sys_info() {
  # get cpu usage in percent
  CPU_USAGE=$(LC_ALL=C top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

  # get memory usage in percent
  RAM_USAGE=$(free -m | awk '/Mem:/ { printf("%3.1f%%", $3 / $2 * 100) }' | sed 's/%//g')

  # get disk space usage in percent
  DISK_USAGE=$(df -h | grep '/dev/sda2' | awk '{ print $5 }' | sed 's/%//g')

  # set variables for the state and tooltip (using printf to format the output)
  STATE=$(printf " %02d |  %02d |  %02d" $CPU_USAGE $RAM_USAGE $DISK_USAGE)
  TOOLTIP=$(printf "CPU: %02d RAM: %02d DISK: %02d" $CPU_USAGE $RAM_USAGE $DISK_USAGE)

  printf "{ \"text\": \"$STATE\", \"tooltip\": \"$TOOLTIP\" }\n"
}

"$@"
