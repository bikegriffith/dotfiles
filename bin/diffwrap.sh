#!/bin/bash
#
# Use this script as an argument to the diff-cmd option for svn diff.  It will
# throw results in a vimdiff window instead of having plaintext diff output.
# For example, you might want to throw an alias in your .bashrc:
#   alias svndiff='svn diff --diff-cmd $HOME/bin/diffwrap.sh'
shift 5; /usr/bin/vimdiff -f "$@"
