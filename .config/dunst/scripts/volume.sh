#!/bin/sh

# Dependancies 'pamixer' & 'dunst'
# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

get_volume() {
    pamixer --get-volume
}

is_mute() {
    pamixer --get-mute | grep true > /dev/null
}

send_notification() {
    volume=$(get_volume)
    # Send the notification
    if [ "$volume" = "0" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:"$volume"
    elif [ "$volume" -lt "30" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-low-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:"$volume"
    elif [ "$volume" -lt "80" ]; then
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-medium-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:"$volume"
    else
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-high-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Volume $volume" -h int:value:"$volume"
    fi
}

case $1 in
    up)
	pamixer -u -i 1
	send_notification
	;;
    down)
	pamixer -u -d 1
	send_notification
	;;
    mute)
	pamixer -t
	if is_mute ; then
	    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/audio-volume-muted-symbolic.symbolic.png --timeout=1600 --replace=2593 --urgency=normal "Mute" -h string:x-dunst-stack-tage:volume
	else
	    send_notification
	fi
	;;
esac
