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

# Starts WM when logging into tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway
fi
