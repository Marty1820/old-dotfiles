# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# BASH CONFIGUARATION

### EXPORTS
export TERM="xterm-256color"
export EDITOR="nano"
export VISUAL="gedit" #Needed for ranger
export HISTCONTROL=ignoreboth:erasedups

# XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

# History file sizes
HISTSIZE=1000
HISTFILESIZE=2000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
#https://bashrcgenerator.com/
#Using Synth shell at bottom
PS1="\[\033[38;5;135m\][\w]\[$(tput sgr0)\]\[\033[38;5;220m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\[\033[38;5;10m\]->\[$(tput sgr0)\]"

### SET PATHS
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/Scripts" ] ;
  then PATH="$HOME/Scripts:${PATH}"
fi

### CHANGE TITLE OF TERMINALS username@hostname:pwd
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty*|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
    ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### SHOPT
shopt -s checkwinsize # checks term size when bash regains control
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

# IGNORE CAPITALIZATION W/TAB COMPLETION
bind 'set completion-ignore-case on' # Ignore case on auto-completion
#bind 'TAB:menu-complete'

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}

##Aliases
source ~/.bash_aliases

# Downloaded and mofidied from https://github.com/nuke-dash/pokemon-colorscripts-mac
pokemon-colorscripts.sh -r

# Use bash-completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

### BASH INSULTER ###
# sudo wget -O /etc/bash.command-not-found https://gitlab.com/dwt1/bash-insulter/-/raw/master/src/bash.command-not-found
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### DRACULA TTY COLORS ###
if [ "$TERM" = "linux" ]; then
    printf %b '\e[40m' '\e[8]' # set default background to color 0 'dracula-bg'
    printf %b '\e[37m' '\e[8]' # set default foreground to color 7 'dracula-fg'
    printf %b '\e]P0282a36'    # redefine 'black'          as 'dracula-bg'
    printf %b '\e]P86272a4'    # redefine 'bright-black'   as 'dracula-comment'
    printf %b '\e]P1ff5555'    # redefine 'red'            as 'dracula-red'
    printf %b '\e]P9ff7777'    # redefine 'bright-red'     as '#ff7777'
    printf %b '\e]P250fa7b'    # redefine 'green'          as 'dracula-green'
    printf %b '\e]PA70fa9b'    # redefine 'bright-green'   as '#70fa9b'
    printf %b '\e]P3f1fa8c'    # redefine 'brown'          as 'dracula-yellow'
    printf %b '\e]PBffb86c'    # redefine 'bright-brown'   as 'dracula-orange'
    printf %b '\e]P4bd93f9'    # redefine 'blue'           as 'dracula-purple'
    printf %b '\e]PCcfa9ff'    # redefine 'bright-blue'    as '#cfa9ff'
    printf %b '\e]P5ff79c6'    # redefine 'magenta'        as 'dracula-pink'
    printf %b '\e]PDff88e8'    # redefine 'bright-magenta' as '#ff88e8'
    printf %b '\e]P68be9fd'    # redefine 'cyan'           as 'dracula-cyan'
    printf %b '\e]PE97e2ff'    # redefine 'bright-cyan'    as '#97e2ff'
    printf %b '\e]P7f8f8f2'    # redefine 'white'          as 'dracula-fg'
    printf %b '\e]PFffffff'    # redefine 'bright-white'   as '#ffffff'
    clear
fi

## synth-shell-prompt.sh
if [ -f $HOME/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
    source $HOME/.config/synth-shell/synth-shell-prompt.sh
fi
