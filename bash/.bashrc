#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
alias c='clear'

alias f='fastfetch'
alias V='sudo nvim'
alias v='nvim'

alias update='sudo pacman -Syu'
alias clean='sudo pacman -Rns $(pacman -Qdtq)'

# ls
alias ls='eza --icons --group-directories-first -h'
alias ll='eza --icons --group-directories-first -lh'
alias la='eza --icons --group-directories-first -a'

# cd then ls
function cl() { builtin cd "$*" && eza -a1lBhm --width 20 --icons --group-directories-first --color --no-permissions --no-user; }
alias cd='cl'

# shortcuts
alias h='cd ~'
alias dl='cd ~/Downloads'
alias dk='cd ~/Documents'
alias dt='cd ~/dotfiles'
alias cf='cd ~/.config'
alias gm='cd /games'

# upward traversal
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd4='cd ../../../..'

eval "$(zoxide init bash --no-cmd)"
function z()  { __zoxide_z "$@"  && eza -a --icons --group-directories-first; }
function zi() { __zoxide_zi "$@" && eza -a --icons --group-directories-first; }

PS1='[\h \W]\$ '
