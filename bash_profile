# ~/.bash_profile: executed by the command interpreter for login shells.
#
# This file is NOT executed by the graphical login shell!
# If you want to set environment variables, etc for graphical applications,
# put that in ~/.profile instead.

# Start the SSH agent automatically on login. 
pgrep ssh-agent > /dev/null || {
    eval `ssh-agent -s`
}

# Now execute stuff from .profile and .bashrc if such files exist.
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
