#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

export PATH=$PATH:/opt/flex_sdk_3.4/bin
export VIM=/usr/share/vim/vim72/
export SB=$HOME/src/sandbox


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