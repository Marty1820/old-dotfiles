#!/usr/bin/env sh

# Script name that controls screen brightness
bright_script="screen_brightness.sh"

# Process ID of script
bright_PID=$(pgrep -f "$bright_script")

# Status of process STOP/CONT
bright_status="$(ps -o state= -p "$bright_PID")"

bright_toggle() { # Toggle process | STOP/CONT
  if [ "$bright_status" = S ]; then
    kill -STOP "$bright_PID"
  elif [ "$bright_status" = T ]; then
    kill -CONT "$bright_PID"
  fi
}

bright_icon() { # Sets brightness icon
  if [ "$bright_status" = S ]; then
    bright_icon="󰃡"
  elif [ "$bright_status" = T ]; then
    bright_icon="󰳲"
  fi
  echo "$bright_icon"
}

if [ "$1" = "--toggle" ]; then
  bright_toggle
elif [ "$1" = "--icon" ]; then
  bright_icon
fi
