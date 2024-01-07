#!/usr/bin/env sh

STATUS=$(pamixer --get-mute)
VOLUME=$(pamixer --get-volume)

if [ "$STATUS" = "true" ]; then
  echo "󰝟"
else
  if [ "$VOLUME" -ge 66 ]; then
    echo "󰕾"
  elif [ "$VOLUME" -ge 33 ]; then
    echo ""
  else
    echo ""
  fi
fi
