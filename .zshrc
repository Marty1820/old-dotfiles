# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# ZSH CONFIGUARATION

# pacman -S zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# EXPORT
export TERM="xterm-256color"
export EDITOR="nano"
export VISUAL="gedit" #Needed for ranger
export HISTORY_IGNORE="(ls|cd|pwd|exit|history|cd -|cd ..)"

# History
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=5000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Options
setopt autocd extendedglob nomatch notify
unsetopt beep
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Editor Keybindings e=emacs
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

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

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       ex <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.txz)        tar xvf ./"$n"      ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                                7z x ./"$n"         ;;
            *.lzma)             unlzma ./"$n"       ;;
            *.bz2)              bunzip2 ./"$n"      ;;
            *.cbr|*.rar)        unrar x -ad ./"$n"  ;;
            *.gz)               gunzip ./"$n"       ;;
            *.cbz|*.epub|*.zip) unzip ./"$n"        ;;
            *.z)                uncompress ./"$n"   ;;
            *.xz)               unxz ./"$n"         ;;
            *.tbz2)             tar xjf ./"$n"      ;;
            *.tgz)              tar xzf ./"$n"      ;;
            *.tar)              tar xf ./"$n"       ;;
            *.deb)              ar x ./"$n"         ;;
            *.tar.zst)          unzstd ./"$n"       ;;
            *)  echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' is not a valid file"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### Adding Color support
autoload -U colors && colors
[[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

##Aliases
source "$HOME"/.bash_aliases

# Downloaded and mofidied from https://github.com/nuke-dash/pokemon-colorscripts-mac
if [ -f "$HOME"/.local/bin/pokemon-colorscripts.sh ]; then
  pokemon-colorscripts.sh -r
fi

## Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

### BASH INSULTER (works in zsh too) ###
# sudo wget -O /etc/bash.command-not-found https://gitlab.com/dwt1/bash-insulter/-/raw/master/src/bash.command-not-found
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### PROMPT ###
eval "$(starship init zsh)"
