#!/bin/bash

# VIM
# alias vi=mvim
alias crontab='VIM_CRONTAB=true crontab'

# Robo
alias robo='robo --config ~/Source/go/src/github.com/boxcast/robo/robo.yml'

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
