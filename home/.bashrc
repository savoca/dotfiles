#!/bin/bash

[[ $- != *i* ]] && return
[[ -f $HOME/.bash_aliases ]] && . $HOME/.bash_aliases
[[ -f $HOME/.bash_prompt ]] && . $HOME/.bash_prompt
[[ -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

export EDITOR=nano
export PATH=$HOME/.bin:$HOME/.bin/scripts:${PATH}

# Linux CLI
export LS_COLORS='di=1;36:ln=35:so=32;40:pi=33;40:ex=1;32:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

# BSD CLI
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
