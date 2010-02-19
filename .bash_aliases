#!/bin/bash

# Sandbox
alias sb='. $SB/bin/activate; cd $SB/src'
alias sbd='deactivate'
alias svndiff='svn diff --diff-cmd $HOME/bin/diffwrap.sh'

# Enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'


