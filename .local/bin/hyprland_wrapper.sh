#!/bin/sh

cd ~ || exit

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=hyprland
export XDG_SESSION_DESKTOP=hyprland

exec Hyprland >> /dev/null
