#!/usr/bin/env bash

dir="$HOME/.config/rofi/apps"
rofi_command="rofi -theme $dir/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="襤"
reboot="菱"
lock=""
if [[ $(cat /sys/class/power_supply/BAT1/status) == Discharging ]]; then
    suspend="⏼"
else
    suspend="鈴"
fi
logout="﫼"

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "    $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
		light-locker-command -l
        ;;
    $suspend)
        if [[ $(cat /sys/class/power_supply/BAT1/status) == Discharging ]]; then
		    light-locker-command -l
		    systemctl hibernate
		else
		    light-locker-command -l
		    systemctl suspend
		fi
        ;;
    $logout)
		qtile cmd-obj -o cmd -f shutdown
        ;;
esac
