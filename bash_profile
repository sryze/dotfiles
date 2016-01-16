# ~/.bash_profile: executed by the command interpreter for login shells.
#
# This file is NOT executed by the graphical login shell!
# If you want to set environment variables, etc for graphical applications,
# put that in ~/.profile instead.

# Execute commands from a local .profile if it exists.
if [ -f ~/.profile.local ]; then
    . ~/.profile.local
fi

# Execute .bashrc if it exists.
# This appears to be not necessary on Linux but some systems don't run .basrc
# automatically, e.g. Mac OS X. (yeah, I don't like Macs too).
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
