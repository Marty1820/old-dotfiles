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
HISTFILE=~/.histfile
HISTSIZE=2000
HISTFILESIZE=2000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
      *.cbt|*.txz)        tar xvf "$1"      ;;
      *.7z|*.arj|*.cab|*.cb7|*.chm|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                          7z x "$1"         ;;
      *.lzma)             unlzma "$1"       ;;
      *.bz2)              bunzip2 "$1"      ;;
      *.cbr|*.rar)        unrar x -ad "$1"  ;;
      *.gz)               gunzip "$1"       ;;
      *.cbz|*.epub|*.zip) unzip "$1"      ;;
      *.z)                uncompress "$1"   ;;
      *.xz)               unxz "$1"         ;;
      *.tbz2)             tar xjf "$1"      ;;
      *.tgz)              tar xzf "$1"      ;;
      *.tar)              tar xf "$1"       ;;
      *.deb)              ar x "$1"         ;;
      *.tar.zst)          unzstd "$1"       ;;
      *)  echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
      echo "'$1' is not a valid file"
  fi
}

##Aliases
source "$HOME"/.sh_aliases

# Downloaded and mofidied from https://github.com/nuke-dash/pokemon-colorscripts-mac
if [ -f "$HOME"/.local/bin/pokemon-colorscripts.sh ]; then
  pokemon-colorscripts.sh -r
fi

# Use bash-completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

### BASH INSULTER ###
# sudo wget -O /etc/bash.command-not-found https://gitlab.com/dwt1/bash-insulter/-/raw/master/src/bash.command-not-found
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### PROMPT ###
PS1="\[\033[38;5;135m\][\w]\[$(tput sgr0)\]\[\033[38;5;220m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\[\033[38;5;10m\]->\[$(tput sgr0)\]"
eval "$(starship init bash)"
