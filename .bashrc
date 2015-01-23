#
# ~/.bashrc
#

# History stuff
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# exports and such
export EDITOR=nano
export PATH=$HOME/bin:${PATH}

if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# colors and such
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# aliases and such for general
alias pls='sudo'
alias ..='cd ..'

# for git stuff
alias pik='git cherry-pick'
alias pikab='git cherry-pick --abort'
alias gaa='git add --all'
alias stat='git status'
alias cmt='git commit'
alias psh='git push'
alias rvt='git revert'

# for ssh'ing
alias ssh-node2='ssh savoca@node2-c6100.codefi.re'
alias ssh-savoca='ssh savoca@savoca.codefi.re'

# for all other programs
alias wallpaper='feh --bg-fill'
alias sdr='screen -d -r'
alias tortilla='transmission-cli -w /home/savoca/Torrents/'
alias ranger='python3 /usr/bin/ranger'
alias muhip='curl -s checkip.dyndns.org | cut -f 6 -d " " | cut -f 1 -d "<"'

function lastcommit {
	git log $1 --pretty=oneline | head -1 | cut -f 1 -d " "
}

# prompt and such
function git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[0;32m\]$(git_branch)\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'
