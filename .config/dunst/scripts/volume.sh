#!/usr/bin/env sh

# Dependancies 'pamixer' & 'dunst'
# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

# Icons
vol_high=/usr/share/icons/dracula-icons/16/panel/audio-volume-high.svg
vol_med=/usr/share/icons/dracula-icons/16/panel/audio-volume-medium.svg
vol_low=/usr/share/icons/dracula-icons/16/panel/audio-volume-low.svg
vol_mute=/usr/share/icons/dracula-icons/16/panel/audio-volume-muted.svg

# Gets volume percent without the '%' sign
get_volume() {
	pamixer --get-volume
}

# Checks if volume is muted
is_mute() {
	pamixer --get-mute | grep true >/dev/null
}

send_notification() {
	volume=$(get_volume)
	# Specialized bar
	bar=$(seq -s "─" 0 $((volume / 5)) | sed 's/[0-9]//g')
	# Send the notification
	if [ "$volume" = "0" ]; then
		dunstify -i "$vol_mute" --timeout=1600 --replace=2593 --urgency=normal "$volume    $bar"
	elif [ "$volume" -lt "30" ]; then
		dunstify -i "$vol_low" --timeout=1600 --replace=2593 --urgency=normal "$volume    $bar"
	elif [ "$volume" -lt "80" ]; then
		dunstify -i "$vol_med" --timeout=1600 --replace=2593 --urgency=normal "$volume    $bar"
	else
		dunstify -i "$vol_high" --timeout=1600 --replace=2593 --urgency=normal "$volume    $bar"
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
	if is_mute; then
		dunstify -i "$vol_mute" --timeout=1600 --replace=2593 --urgency=normal "Mute" -h string:x-dunst-stack-tage:volume
	else
		send_notification
	fi
	;;
esac
