# ~/.bash_profile: executed by the command interpreter for login shells.
#
# This file is NOT executed by the graphical login shell!
# If you want to set environment variables, etc for graphical applications,
# put that in ~/.profile instead.

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
