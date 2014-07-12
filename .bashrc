# ~/.bashrc

# History stuff
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nano
export PATH=${PATH}:~/bin

# Colors for ls and grep!
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Bash Completion
if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Intro
if [ -f ~/.bash_intro ]; then
    . ~/.bash_intro skip
fi

# Prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi
