#!/usr/bin/env bash 

/usr/bin/picom &
/usr/bin/gnome-keyring-daemon &
/usr/bin/blueman-applet &
/usr/bin/conky &
/usr/bin/redshift &
/usr/bin/light-locker &
/usr/bin/kdeconnect-indicator &
~/.local/bin/notifications.py &
/usr/bin/feh --bg-fill --randomize ~/wallpapers/* &
