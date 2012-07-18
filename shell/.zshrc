source ~/.shrc
source ~/.promptrc
source ~/.termtitle

HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=25000

#Do not overwrite history file so two parallel shells
# don't overwrite each other's history
setopt appendhistory

#Ignore duplicate lines
setopt hist_ignore_all_dups
#Expire duplicates before removing unique entries
setopt hist_expire_dups_first


setopt extendedglob
setopt autocd

setopt ignorebraces

unsetopt beep

zstyle :compinstall filename '/home/asmageddon/.zshrc'

autoload -Uz compinit && compinit

bindkey -e
#Include / for smarter behavior when ctrl+arrowing through paths
#And $ for shell variables
WORDCHARS="${WORDCHARS//[&=\/;!$#%{]}"

bindkey "^[[1;5C" vi-forward-word
bindkey "^[[1;5D" vi-backward-word