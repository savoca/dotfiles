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

# colors and such
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# aliases and such
alias pls='sudo'
alias pik='git cherry-pick'
alias pikab='git cherry-pick --abort'
alias gaa='git add --all'
alias stat='git status'
alias cmt='git commit'
alias psh='git push'
alias rvt='git revert'
alias gedit='gedit $1 > /dev/null 2>&1'
alias ..='cd ..'
alias codefire='ssh savoca@node2-c6100.codefi.re'
alias savocavm='ssh savoca@savoca.codefi.re'
alias wallpaper='feh --bg-scale'
alias wifi='nmcli device wifi connect' #<ssid> password <password>
alias wifioff='nmcli device disconnect wlo1' #wlo1 for main pc

# prompt and such
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
