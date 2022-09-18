# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# ZSH PROFILE

# Import zshrc
[[ -f ~/.zshrc ]] && . ~/.zshrc

# Starts Gnome-keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# Starts WM when logging into tty
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
  $HOME/.local/bin/hyprland_wrapper.sh
fi

if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty2" ]; then
  $HOME/.local/bin/sway_wrapper.sh
fi
