# ~/.bash_profile: executed by the command interpreter for login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Set PATH so it includes user's private bin if it exists.
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
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
export PATH="$PATH:$HOME/.local/bin"
export POWERLINE_ROOT="$HOME/.local/lib/python2.7/site-packages"
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
powerline-daemon -q
. "$POWERLINE_ROOT/powerline/bindings/bash/powerline.sh"

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

# Execute commands from a local .bash_profile if it exists.
if [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi

# Execute .bashrc if it exists.
# This appears to be not necessary on Linux but some systems don't run .basrc
# automatically, e.g. Mac OS X (yeah, I don't like Macs too).
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
