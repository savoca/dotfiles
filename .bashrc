# ~/.bashrc

[[ $- != *i* ]] && return
[[ -f $HOME/.bash_aliases ]] && . $HOME/.bash_aliases
[[ -f $HOME/.bash_prompt ]] && . $HOME/.bash_prompt
[[ -f /usr/share/bash-completion/bash_completion ]] &&
	. /usr/share/bash-completion/bash_completion

export EDITOR=nano
export PATH=$HOME/.bin:$HOME/.bin/scripts:${PATH}
