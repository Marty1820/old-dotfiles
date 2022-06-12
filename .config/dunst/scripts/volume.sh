#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -M get Master | grep '%' | cut -d '[' -f 2 | cut -d '%' -f 1 | awk 'NR==1'
}

function is_mute {
    amixer -M get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=$(get_volume)
    # Send the notification
    if [ "$volume" = "0" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:$volume
    elif [ "$volume" -lt "30" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-low-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:$volume
    elif [ "$volume" -lt "80" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-medium-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:$volume
    else
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-high-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:$volume
    fi
}

case $1 in
    up)
	amixer -qM set Master 1%+ unmute
	send_notification
	;;
    down)
	amixer -qM set Master 1%- unmute
	send_notification
	;;
    mute)
	amixer -qM set Master toggle
	if is_mute ; then
	    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Mute" -h string:x-dunst-stack-tage:volume
	else
	    send_notification
	fi
	;;
esac
