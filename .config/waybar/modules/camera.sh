#!/bin/sh

camdir="/sys/class/video4linux/video0"
camchk=$(lsmod | awk '$1 ~ /uvcvideo/ {print $3}')

text=""
tooltip=""
class=""
percentage=""

if [ -d "$camdir" ]; then
  text="Enabled"
  tooltip="Camera is enabled"
  class=""
  if [ "$camchk" -eq 1 ]; then
    text="In Use"
    tooltip="Camera in use"
    class="critical"
    percentage="100"
  fi
else
  exit 0
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\", \"percentage\": \"$percentage\" }"
