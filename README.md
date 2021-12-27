# Marty's Dots
**Warning:** If you want to give these files a try, you should first read them to verify it'll fit your needs, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk! NO WARRANTIES/NO REFUNDS!!!

Otherwise these are pretty basic configs with nothing special.

## Details
* WM: [qtile](http://www.qtile.org)
* Colors/Themes: [Dracula](https://draculatheme.com)
* Terminal: Alacritty
* Application launcher/logout screen: [rofi](https://github.com/davatorium/rofi)

![screenshot](.screenshots/desktop.png)
![screenshot](.screenshots/term-fetch.png)
![screenshot](.screenshots/logout-menu.png)
![screenshot](.screenshots/apps-menu.png)

## Programs my dots use
|Name|Description|
|:----------:|:-------------:|
|`scrot`|Print Screen key takes screenshot|
|`xbacklight`|Laptop brightness keys|
|`lightdm`|change in qtile config & rofi powermenu.sh|
|Fonts|`mononoki` for panel & `hack` for everything else|
|`vivaldi-stable`|ctrl + b to open|
|`pcmanfm`|ctrl + e to open|
|`gedit`|ctrl + a to open|

## Autostarted/change in [.config/qtile/autostart.sh](https://github.com/Marty1820/dotfiles/blob/master/.config/qtile/autostart.sh)

+ `picom` : transparency & blur
+ `feh` : sets wallpaper
+ `conky` : shows keybindings (X means I haven't implimented it yet)
+ `redshift` : limits blue light
+ `xfce4-power-manager` : laptop powermangement (there are better ways to do this/just google it)
+ `light-locker` : used to lock screen/replacement for dm-tools
+ `kdeconnectd` : phone integration

## Thanks to/Original Sources...
* Anywhere I could I added a link to the original in the configs/I propbably missed a lot though.
* [Distro Tube](https://distro.tube/) and his [dotfiles](https://gitlab.com/dwt1/dotfiles)
* And of course [Dracula Theme](https://github.com/dracula/dracula-theme) since I tend to use it on everthing I possibly can.