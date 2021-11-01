DISABLE_MAGIC_FUNCTIONS=true

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in $ZSH/plugins/*)
plugins=(git brew tmux)

# User configuration
source $ZSH/oh-my-zsh.sh

# unsetopt inc_append_history
# unsetopt share_history

# Set locale and language to US English.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Advertise 256-color support.
export TERM=xterm-256color

# Preferred editor for local and remote sessions.
if [[ -n "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# Some handy aliases.
alias ls='ls -G'
alias g='git status'
alias gd='git diff'
alias gl='git log'
alias groot="cd \$(git rev-parse --show-toplevel)"
alias ip='ifconfig | grep 192\.168\.'

a() { git add "$@" } 
c() { git commit "$@" }
t() { tree -C "$@" | less -RFX }

httpless() {
    http --pretty=all --print=hb "$@" | less -RFX
}

alias h='httpless'

# Replace vim with nvim if installed.
if [[ -n "$(command -v nvim)" ]]; then
    alias vim='nvim'
fi

# User shell scripts
export PATH=$PATH:$HOME/.local/bin

if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
