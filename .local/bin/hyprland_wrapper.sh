#!/bin/sh

cd ~ || exit

# XDG Specifications
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

# QT Variables
export QT_QPA_PLATFORM=wayland

# Toolkit Backend
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export GDK_BACKEND=wayland,x11

# Theming
export XCURSOR_SIZE=24

# Misc.
export MOZ_ENABLE_WAYLAND=1

exec Hyprland >> /dev/null
