source ~/.shrc
source ~/.promptrc
source ~/.termtitle

HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=25000

setopt appendhistory hist_ignore_all_dups extendedglob autocd
unsetopt beep

zstyle :compinstall filename '/home/asmageddon/.zshrc'

autoload -Uz compinit && compinit

bindkey -e
#Include / for smarter behavior when ctrl+arrowing through paths
#And $ for shell variables
WORDCHARS="${WORDCHARS//[&=\/;!$#%{]}"

bindkey "^[[1;5C" vi-forward-word
bindkey "^[[1;5D" vi-backward-word