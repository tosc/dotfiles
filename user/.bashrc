#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use Color for ls
alias ls='ls --color=auto'

# Normal prompt without color
# PS1='[\u@\h \w] '
# Better prompt.
# 30 black, 31 red, 32 green, 33 yellow, 34 blue, 35 purple, 36 cyan, 37 white
PS1='\[\033[1;34m\][\u \w]\[\033[0m\] '

# Use vim to look at manpages.
export MANPAGER="vimpager"

# Sets ratpoison title to last command.
trap 'RAT_TITLE=${BASH_COMMAND%% *}; if [ "$RAT_TITLE" == "printf" ]; then RAT_TITLE="Xterm"; fi; ratpoison -c "title $RAT_TITLE"' DEBUG

# Removes the ctrl-s and ctrl-q bindings.
stty -ixon

alias ls='ls --color=auto'
alias sftp='cd /home/opo/down; sftp'
alias steam='steam-native'
