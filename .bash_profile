# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# BASH PROFILE

# Import bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Starts Gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Starts WM when logging into tty
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland >>/dev/null
  #$HOME/.local/bin/hyprland_wrapper.sh
fi

if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty2" ]; then
  #exec sway >>/dev/null
  $HOME/.local/bin/sway_wrapper.sh
fi
