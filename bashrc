# ~/.bashrc: executed by bash(1) for non-login shells.

# Enable programmable completion features.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# History search with Up/Down keys.
bind '"\eOA": history-search-backward'
bind '"\e[A": history-search-backward'
bind '"\eOB": history-search-forward'
bind '"\e[B": history-search-forward'

# Enable colored output in various shell commands.
alias grep="grep --color=auto"
if [ "$OSTYPE" == "linux-gnu" ]; then
    alias ls="ls --color=auto"
else
    alias ls="ls -G"
fi

# The Fuck: https://github.com/nvbn/thefuck
if [ "$(command -v thefuck)" ]; then
    alias fuck="$(thefuck $(fc -ln -1))"
fi

# Bash completions for grunt (npm install -g grunt-cli).
if [ "$(command -v grunt)" ]; then
    eval "$(grunt --completion=bash)"
fi

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Set language/locale to US English.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Replace vim with nvim if installed.
if [[ -n "$(command -v nvim)" ]]; then
  alias vim='nvim'
fi

# Set EDITOR to vim if installed, otherwise use vi (which is available
# pretty much everywhere).
if [ "$(command -v vim)" ]; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# Powerline: statusline for Bash (https://github.com/powerline/powerline)
# Install powerline with 'pip install --user powerline-status'.
if [ -z "$SSH_CLIENT" ] && [ "$TERM" != "linux" ]; then
    if [ "$(command -v powerline-daemon)" ]; then
    	export POWERLINE_ROOT="$HOME/.local/lib/python2.7/site-packages"
    	export POWERLINE_BASH_CONTINUATION=1
    	export POWERLINE_BASH_SELECT=1
    	powerline-daemon -q
    	. "$POWERLINE_ROOT/powerline/bindings/bash/powerline.sh"
    fi
fi

# Tell the world that we can do 256 colors.
# This is needed for tmux and possibly other things that I can't remember.
if [ "$TERM" != "linux" ]; then
    export TERM="xterm-256color"
fi

# Linuxbrew: https://github.com/Homebrew/linuxbrew
# (for installing latest versions of some tools).
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"

# Some handy aliases.
alias g='git status'
alias ta='tmux attach'

tree_less() {
    tree -C "$@" | less -RFX
}
alias tree='tree_less'

http_less() {
    http --pretty=all --print=hb "$@" | less -RFX
}
alias http='http_less'

# Execute commands from a local .bashrc if exists.
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
