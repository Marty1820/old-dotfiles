#!/usr/bin/python3
# pacman -S libappindicator-gtk3
import os, gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk as gtk, AppIndicator3 as appindicator

def main():
    indicator = appindicator.Indicator.new("customtray", "mail-read-symbolic",
    appindicator.IndicatorCategory.APPLICATION_STATUS)
    indicator.set_status(appindicator.IndicatorStatus.ACTIVE)
    indicator.set_menu(menu())
    gtk.main()

def menu():
    menu = gtk.Menu()
    
    command_one = gtk.MenuItem.new_with_label("Toggle DUNST")
    command_one.connect('activate', toggle)
    menu.append(command_one)
    
    command_two = gtk.MenuItem.new_with_label('Last Notification')
    command_two.connect('activate', notification)
    menu.append(command_two)
    
    exittray = gtk.MenuItem.new_with_label('Exit Tray')
    exittray.connect('activate', quit)
    menu.append(exittray)
    
    menu.show_all()
    return menu

def toggle(_):
    os.system("dunstctl set-paused toggle")

def notification(_):
    os.system("dunstctl history-pop")

def quit(_):
    gtk.main_quit()

if __name__ == "__main__":
    main()
