# ~/.bashrc: executed by bash(1) for non-login shells.

# Fix annoying window renaming in tmux on Fedora.
export PROMPT_COMMAND=

# Enable programmable completion features.
if ! shopt -oq posix; then
  if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  fi
  if [ $(uname -s) = "Darwin" ] && [[ -n "$(command -v brew)" ]]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      source $(brew --prefix)/etc/bash_completion
    fi
  fi
fi

# History search with Up/Down keys.
if [[ $- == *i* ]]; then
  bind '"\eOA": history-search-backward'
  bind '"\e[A": history-search-backward'
  bind '"\eOB": history-search-forward'
  bind '"\e[B": history-search-forward'
fi

# Enable colored output in various shell commands.
alias grep='grep --color=auto'
if [ "$OSTYPE" == "linux-gnu" ]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
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
using_powerline=
if [ -z "$SSH_CLIENT" ] && [ "$TERM" != "linux" ]; then
  export POWERLINE_ROOT=$(python3 -m site --user-site)
  if [ -d "$POWERLINE_ROOT" ]; then
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    powerline-daemon -q
    source "$POWERLINE_ROOT/powerline/bindings/bash/powerline.sh"
    using_powerline=yes
  fi
fi

if [ "$using_powerline" != "yes" ]; then
  # Use a simple prompt based on deault .bashrc from Debian/Ubuntu.
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi
  case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
  esac
  if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      # We have color support; assume it's compliant with Ecma-48
      # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
      # a case would tend to support setf rather than setaf.)
      color_prompt=yes
    else
      color_prompt=
    fi
  fi
  if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt
  case "$TERM" in
    xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
    *)
      ;;
  esac
fi

# Tell the world that we can do 256 colors.
# This is needed for tmux and possibly other things that I can't remember.
if [ "$TERM" != "linux" ] && [ $(uname -s) != MINGW* ]; then
  export TERM="xterm-256color"
fi

# Git Bash's PS1 contains a call to __git_ps1 which is way too slow (it's
# the thing that prints the current git branch).
if [ $(uname -s) = MINGW* ]; then
  export PS1="\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]\[\033[0m\]\n$ "

  # https://github.com/docker/toolbox/issues/673
  docker() {
      (export MSYS_NO_PATHCONV=1; "docker.exe" "$@")
  }
fi

# Remove ugly background color from directories in in ls output.
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

# Some handy aliases.
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias g='git status'
alias ta='tmux attach'
alias groot='cd "$(git rev-parse --show-toplevel)"'
alias dc='docker-compose'

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
  source ~/.bashrc.local
fi
