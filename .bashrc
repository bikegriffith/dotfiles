#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

export VIM=/usr/share/vim/vim80/

# Ruby things
export RESTCLIENT_LOG=stdout
export DSN='mysql://root@localhost(3306)/test'
export REDIS_URL='redis://localhost:6379'

# Roku things
export ROKU_DEV_TARGET=192.168.1.13
export DEVPASSWORD=password

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Golang
export GOPATH="$HOME/Source/go"
export PATH="$PATH:$GOPATH/bin"

# Start ssh-agent with my private keys
export HOSTNAME=`hostname` # HOSTNAME not set some machines
if [ -x /usr/bin/keychain -a -f $HOME/.keychain/${HOSTNAME}-sh ] ; then
    (/usr/bin/keychain $HOME/.ssh/id_rsa 2>&1) > /dev/null
    (/usr/bin/keychain $HOME/.ssh/agi-openssh-key 2>&1) > /dev/null
    source $HOME/.keychain/${HOSTNAME}-sh
fi

# If not running interactively, don't do anything else
[ -z "$PS1" ] && return


# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Prompt configuration
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Programmable completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi
if [ -f /usr/local/etc/bash_completion.d/npm ]; then
    . /usr/local/etc/bash_completion.d/npm
fi

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
# if not found in /usr/local/etc, try the brew --prefix location
[ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
. $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
