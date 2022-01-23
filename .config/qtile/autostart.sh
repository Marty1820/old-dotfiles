#!/usr/bin/env bash 

picom &
gnome-keyring-daemon &
blueman-applet &
conky &
redshift &
light-locker &
/usr/lib/kdeconnectd &
~/.local/bin/notifications.py &
feh --bg-fill --randomize ~/wallpapers/* &
