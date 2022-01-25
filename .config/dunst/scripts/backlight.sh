#!/bin/bash

# You can call this script like this:
# $./backlight.sh up
# $./backlight.sh down

function get_backlight {
    fullnum=$(xbacklight -get)
    printf %.0f $fullnum
}

function send_notification {
    backlight=`get_backlight`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($backlight / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/display-brightness-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$backlight    $bar"
}

case $1 in
    up)
	# Up the volume (+ 5%)
	xbacklight -inc 5 > /dev/null
	send_notification
	;;
    down)
	xbacklight -dec 5 > /dev/null
	send_notification
	;;
esac
