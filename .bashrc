#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Use Color for ls
alias ls='ls --color=auto'

# Better prompt.
PS1='[\u@\h \w]\$ '

# Use vim to look at manpages.
export MANPAGER="vimpager"

# Sets ratpoison title to last command.
trap 'RAT_TITLE=${BASH_COMMAND%% *}; if [ "$RAT_TITLE" == "printf" ]; then RAT_TITLE="Xterm"; fi; ratpoison -c "title $RAT_TITLE"' DEBUG
