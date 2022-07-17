#!/bin/sh

# Commands
lock_cmd="swaylock"
#lock_cmd="i3lock -i ~/wallpapers/lockscreen.png"
rofi_conf="rofi -theme $HOME/.config/rofi/apps/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Icons
shutdown="襤"
reboot="菱"
lock=""
if [ "$(cat /sys/class/power_supply/BAT1/status)" = Discharging ]; then
  suspend="⏼"
else
  suspend="鈴"
fi
logout="﫼"

chosen=$(printf '%s;%s;%s;%s;%s\n' "$shutdown" "$reboot" "$lock" "$suspend" "$logout" \
  | $rofi_conf \
    -p "  祥  $uptime" \
    -dmenu \
    -sep ';' \
    -selected-row 2)

case "$chosen" in
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
    if [ "$(cat /sys/class/power_supply/BAT1/status)" = Discharging ]; then
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
