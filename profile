# ~/.profile: executed by the command interpreter for login shells.

# Start ssh-agent on login.
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add
fi

if [ -f "$HOME/.profile.local" ]; then
    . "$HOME/.profile.local"
fi
