#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias c='clear'
alias f='fastfetch'
alias m='unimatrix -l s'
alias v='nvim'
alias sv='sudo nvim'

alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'
alias please='sudo $history -p !!)'

PS1='[\u@\h \W]\$ '

fastfetch
