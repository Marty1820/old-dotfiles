#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -M get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -M get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification
    if [ "$volume" = "0" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$volume    $bar"
    elif [ "$volume" -lt "30" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-low-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$volume    $bar"
    elif [ "$volume" -lt "80" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-medium-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$volume    $bar"
    else
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-high-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$volume    $bar"
    fi
}

case $1 in
    up)
	amixer -qM set Master 1%+ unmute > /dev/null
	send_notification
	;;
    down)
	amixer -qM set Master 1%- unmute > /dev/null
	send_notification
	;;
    mute)
	amixer -qM set Master 1+ toggle > /dev/null
	if is_mute ; then
	    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "Mute"
	else
	    send_notification
	fi
	;;
esac
