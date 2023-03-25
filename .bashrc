# ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
# ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
# ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
# ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
# ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
# BASH CONFIGUARATION

### EXPORTS
export HISTCONTROL=ignoreboth:erasedups

##Aliases
[[ -f "$HOME"/.config/shell/shellrc ]] && . "$HOME"/.config/shell/shellrc

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

# Use bash-completion
[[ -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

### PROMPT ###
#PS1="\[\033[38;5;135m\][\w]\[$(tput sgr0)\]\[\033[38;5;220m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\[\033[38;5;10m\]->\[$(tput sgr0)\]"
eval "$(starship init bash)"
