#!/usr/bin/env sh

STATUS=$(nmcli -t -f STATE g)

toggle() {
  [ "$STATUS" = "connected" ] && nmcli radio wifi off || nmcli radio wifi on
}

status() {
  [ "$STATUS" = "connected" ] && echo "󰤨" || echo "󰤭"
}

if [ "$1" = "--toggle" ]; then
  toggle
elif [ "$1" = "--status" ]; then
  status
fi
