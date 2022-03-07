# Marty's Dotfiles

**Warning:** If you want to give these files a try, you should first modify them to fit your needs, and remove things you don’t want or need. Don’t blindly use online code unless you know what's in it and what it does. Use at your own risk! NO WARRANTIES/NO REFUNDS!!!

Otherwise these are pretty basic configs with nothing special.

## Details

- WM: [qtile](http://www.qtile.org) or [i3](https://i3wm.org/docs/)
- Colors/Themes: [Dracula](https://draculatheme.com)
- Terminal: [Alacritty](https://github.com/alacritty/alacritty)
- Application launcher/logout screen: [rofi](https://github.com/davatorium/rofi)
- Lock Screen: [i3lock](https://i3wm.org/i3lock/)
- System Monitor: [conky](<https://en.wikipedia.org/wiki/Conky_(software)>)

# Qtile

![screenshot](.screenshots/qtile.png)

# i3/i3blocks bar

![screenshot](.screenshots/i3.png)

# Extras/Menus

![screenshot](.screenshots/logout-menu.png)
![screenshot](.screenshots/apps-menu.png)

## Keybound Apps

|          Name          |                      Description                      |
| :--------------------: | :---------------------------------------------------: |
|        `gedit`         |                      `Super + a`                      |
|       `pcmanfm`        |                      `Super + e`                      |
|        `brave`         |                      `Super + b`                      |
|         `rofi`         | `Super + d` = applications & `Ctrl + Esc` = exit menu |
|        `scrot`         |           Print Screen key for screenshots            |
|   `xorg-xbacklight`    |                Laptop brightness keys                 |
|         `btop`         |                 click RAM to bring up                 |
| `nm-connection-editor` |                 click Network Widget                  |

## Fonts

|         Name          |              Description               |
| :-------------------: | :------------------------------------: |
|      `mononoki`       | Used for bar installed with nerd-fonts |
|      `ttf-hack`       |          for everything else           |
| `nerd-fonts-complete` |           from AUR for icons           |

## .bashrc alias's

|       Name        |                   Description                    |
| :---------------: | :----------------------------------------------: |
|       `exa`       |                 `ls` replacement                 |
|     `pacman`      |               Arch package manager               |
|      `paru`       |             Arch AUR package manager             |
|    `reflector`    |             Updates mirrors on Arch              |
|   `youtube-dl`    | Download youtube videos/audio with `ytv` & `yta` |
|    `starship`     |           Changes the terminal prompt            |
| Compression Tools | `ex filename.ext` extracts most compressed files |

## Autostarted/change in [.config/qtile/autostart.sh](https://github.com/Marty1820/dotfiles/blob/master/.config/qtile/autostart.sh)

- `picom` : transparency & blur
- `blueman-applet` : Autostarts bluetooth
- `conky` : shows keybindings
- `redshift` : limits blue light
- `kdeconnect-indicator` : phone notifications
- `feh` : sets wallpaper from "~/wallpapers/\*"

**Custom scripts**

- `notifications.py` : allows easily seeing previous Dunst notifications
- `low_bat` : Monitors battery and sends warning when battery is low

## Thanks to/Original Sources

- Reddit [u/emanuelep57](https://www.reddit.com/user/emanuelep57) for help with the volume widget & [u/FrostCastor](https://www.reddit.com/user/FrostCastor) for help with the battery indicator code
- [Distro Tube](https://distro.tube/) and his [dotfiles](https://gitlab.com/dwt1/dotfiles)
- And of course [Dracula Theme](https://github.com/dracula/dracula-theme) since I tend to use it on everthing I possibly can.
