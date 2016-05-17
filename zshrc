# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in $ZSH/plugins/*)
plugins=(git brew tmux)

# User configuration
source $ZSH/oh-my-zsh.sh

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

# The Fuck: https://github.com/nvbn/thefuck
# Usage: fuck
eval "$(thefuck --alias)"

# git + hub = github
# https://github.com/github/hub
eval "$(hub alias -s)"

# Python pip packages
export PATH=$PATH:$HOME/Library/Python/2.7/bin

# Infer: https://github.com/facebook/infer
export PATH=$PATH:$HOME/infer-osx-v0.4.0/infer/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin
export RUST_SRC_PATH=$HOME/rust/src

# Android
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
