#!/bin/bash 

/usr/bin/picom &
/usr/bin/gnome-keyring-daemon &
/usr/bin/blueman-applet &
/usr/bin/conky &
/usr/bin/redshift &
/usr/bin/light-locker &
/usr/bin/kdeconnect-indicator &
/usr/bin/feh --bg-fill --randomize ~/wallpapers/* &

## Custom made
# allows seeing last notification with dunst/adds to systray
~/.local/bin/notifications.py &
# sends notification when battery is low
~/.local/bin/low_bat &
