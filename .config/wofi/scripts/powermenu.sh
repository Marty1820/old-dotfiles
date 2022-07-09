#!/bin/bash

op=$( echo -e "襤 Shutdown\n拉 Reboot\n鈴 Suspend\n⏼ Hibernate\n Lock\n Logout" | wofi -i --dmenu | awk '{print tolower($2)}' )

case $op in 
  shutdown)
    systemctl poweroff
    ;;
  reboot)
    systemctl reboot
    ;;
  suspend)
    swaylock && systemctl suspend
    ;;
  hibernate)
    swaylock && systemctl hibernate
    ;;
  lock)
		swaylock
    ;;
  logout)
    swaymsg exit
    ;;
esac
