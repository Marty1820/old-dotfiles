#!/usr/bin/env sh

/usr/bin/picom &
/usr/bin/blueman-applet &
/usr/bin/conky &
/usr/bin/redshift -l "$(curl -s "https://location.services.mozilla.com/v1/geolocate?key=geoclue" | awk 'OFS=":" {print $3,$5}' | tr -d ',}')" &
/usr/bin/kdeconnect-indicator &
/usr/bin/feh --bg-fill --randomize ~/wallpapers/* &

## Custom made
# allows seeing last notification with dunst/adds to systray
~/.local/bin/notifications.py &
# sends notification when battery is low
~/.local/bin/low_bat &

# Screen Lock setup
xss-lock -- i3lock -n -i ~/wallpapers/lockscreen.png &
