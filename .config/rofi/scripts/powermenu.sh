#!/bin/bash

lock_cmd="swaylock"
#lock_cmd="i3lock -i ~/wallpapers/lockscreen.png"

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

chosen="$(echo -e "$options" | $rofi_command -p "  祥  $uptime" -dmenu -selected-row 2)"
case $chosen in
  "$shutdown")
    systemctl poweroff
    ;;
  "$reboot")
    systemctl reboot
    ;;
  "$lock")
    $lock_cmd
    ;;
  "$suspend")
    if [[ $(cat /sys/class/power_supply/BAT1/status) == Discharging ]]; then
		  $lock_cmd
		  systemctl hibernate
		else
		  $lock_cmd
      systemctl suspend
    fi
    ;;
  "$logout")
    session=$(loginctl session-status | head -n 1 | awk '{print $1}')
    loginctl terminate-session "$session"
    ;;
esac
