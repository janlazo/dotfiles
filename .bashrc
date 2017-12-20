[ -z "$PS1" ] && return; # don't do anything if not running interactively

set -o emacs;            # Force Bash's Emacs Mode

shopt -s extglob         # Enable regex pattern matching
shopt -s globstar        # Enable recursive file search
shopt -s checkwinsize    # check (& update) window size after every command
shopt -s histappend      # append to history file, don't overrite

HISTCONTROL=ignoreboth   # no duplicate lines, lines starting with space
HISTFILESIZE=1000        # max num of lines
HISTSIZE=100             # max num of commands
