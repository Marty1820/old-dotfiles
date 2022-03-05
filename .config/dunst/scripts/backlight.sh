#!/bin/bash

# Dependancies 'xorg-xbacklight' & 'dunst'
# You can call this script like this:
# $./backlight.sh up
# $./backlight.sh down

# Gets brightness percent from 'xbacklight'
function get_backlight {
    fullnum=$(xbacklight -get)
    printf %.0f "$fullnum"
}

# Changes percent increase/decrease 
# depending on current brightness & direction
function set_curve() {
    backlight=$(get_backlight)
    local direction="$1"
    if [ "$direction" = up ]; then
        if [ "$backlight" -lt 10 ] ; then
            percent=1
        elif [ "$backlight" -lt 50 ] ; then
            percent=5
        else
            percent=10
        fi
    else
        if [ "$backlight" -le 10 ] ; then
            percent=1
        elif [ "$backlight" -le 50 ] ; then
            percent=5
        else
            percent=10
        fi
    fi
}

# Sends notification with dunst and set progress bar
function send_notification {
    backlight=$(get_backlight)
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $((backlight / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify --raw_icon=/usr/share/icons/Adwaita/48x48/status/display-brightness-symbolic.symbolic.png --timeout=4500 --replace=2593 --urgency=normal "$backlight    $bar"
}

case $1 in
    up)
    set_curve "up"
	xbacklight -inc $percent > /dev/null
	send_notification
	;;
    down)
    set_curve "down"
	xbacklight -dec $percent > /dev/null
	send_notification
	;;
esac
