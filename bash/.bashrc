#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'

alias f='fastfetch'
alias V='sudo nvim'
alias v='nvim'

alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'

PS1='[\u@\h \W]\$ '
