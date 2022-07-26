#!/usr/bin/env python
# pacman -S libappindicator-gtk3
import os, gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk as gtk, AppIndicator3 as appindicator

def main():
  ind = appindicator.Indicator.new(
    "Notifications",
    "indicator-messages",
    appindicator.IndicatorCategory.APPLICATION_STATUS
  )
  ind.set_status (appindicator.IndicatorStatus.ACTIVE)
  ind.set_menu(menu())
  gtk.main()

def menu():
  menu = gtk.Menu()

  cmd_tog = gtk.MenuItem.new_with_label("Pause/Un-pause")
  cmd_tog.connect('activate', toggle)
  menu.append(cmd_tog)

  cmd_hist = gtk.MenuItem.new_with_label('Notification History')
  cmd_hist.connect('activate', notification)
  menu.append(cmd_hist)

  cmd_close = gtk.MenuItem.new_with_label('Close All Notifications')
  cmd_close.connect('activate', close)
  menu.append(cmd_close)

  cmd_exit = gtk.MenuItem.new_with_label('Exit Tray')
  cmd_exit.connect('activate', quit)
  menu.append(cmd_exit)

  menu.show_all()
  return menu

def toggle(_):
  os.system("""dunstctl set-paused toggle
if [[ $(dunstctl is-paused) = "false" ]]; then
  dunstify "Notifications" "Notifications are now un-paused"
fi""")

def notification(_):
  os.system("""while read; do dunstctl history-pop; done <<<$(dunstctl history|grep '"id" :')
""")

def close(_):
  os.system("dunstctl close-all")

def quit(_):
  gtk.main_quit()

if __name__ == "__main__":
  main()