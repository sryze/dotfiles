# ~/.bash_profile: executed by the command interpreter for login shells.
#
# This file is NOT executed by the graphical login shell!
# If you want to set environment variables, etc for graphical applications,
# put that in ~/.profile instead.

# Start the SSH agent automatically on login. Credits to this StackOverflow
# user: https://stackoverflow.com/a/18915067/249230

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Now source things from .profile and .bashrc if they exist.

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi
