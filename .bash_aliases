# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# BASH&ZSH ALIASES/FUNCTIONS

### ALIAS ###
alias ..='cd ..'
alias cd..='cd ..'
# Interactive Mode
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
# Human readable formate
alias df='df -h'        # human-readable sizes
alias free='free -h'    # show sizes in human readable
# Colorize
alias tree='tree -C'
alias mkdir='mkdir -p'
alias psa='ps auxf'
alias cls='clear && color10bit.sh'
alias grep='grep --color=auto'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
alias wifikey="sudo grep -r '^psk=' /etc/NetworkManager/system-connections/"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -al --color=always --group-directories-first' # all files and dirs
alias ll='exa -l --color=always --group-directories-first' # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l='exa -a --color=always' # Show all dirs/files
alias l.='exa -a | egrep "^\."' # Show only .dot files

# pacman and paru
alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
alias parusyu='paru -Syu'              # update standard pkgs and AUR pkgs (paru)
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'  # remove orphaned packages

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# GitHub Dot Files
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# youtube-dl
alias yta="youtube-dl --extract-audio --audio-format best "
alias ytv="youtube-dl -f bestvideo+bestaudio "

### FUN STUFF ###
# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
# UTF-8 termnal display tester
alias utftest="curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt"

### FUNCTIONS ###
# Runs ls after cd'ing to dir
function cd() {
    if [ "$1" = "" ]; then
        builtin cd "$HOME"
    else
        builtin cd "$1"
    fi
    ls
}
