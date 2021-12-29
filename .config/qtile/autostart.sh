#!/usr/bin/env bash 

picom &
gnome-keyring-daemon &
blueman-applet &
conky &
redshift &
light-locker &
/usr/lib/kdeconnectd &
feh --bg-fill --randomize ~/Pictures/wallpapers/FrameWork/* &
