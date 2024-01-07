#!/usr/bin/env sh

STATUS=$(bluetoothctl show | awk '/Powered/ {print $2}')

toggle() {
  [ "$STATUS" = "yes" ] && bluetoothctl power off || bluetoothctl power on
}

icon() {
  [ "$STATUS" = "yes" ] && echo "󰂯" || echo "󰂲"
}

if [ "$1" = "--toggle" ]; then
  toggle
elif [ "$1" = "--icon" ]; then
  icon
fi
