#!/bin/bash

# Colored output
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git
alias pik='git cherry-pick'
alias pikab='git cherry-pick --abort'
alias gaa='git add --all'
alias stat='git status'
alias cmt='git commit'
alias psh='git push'
alias rvt='git revert'
alias cln='git checkout -- . && git clean -dfq'

# General/Programs
alias ..='cd ..'
alias tortilla='transmission-cli -w /home/savoca/Torrents/'
alias ranger='python3 /usr/bin/ranger'
alias muhip='curl -s checkip.dyndns.org | cut -f 6 -d " " | cut -f 1 -d "<"'
alias mainline='curl -s https://www.kernel.org/finger_banner | head -1 | cut -c63-'
alias d2h='printf "0x%x\n" $@'
alias h2d='printf "%d\n" $@'
alias adb='adb wait-for-device'

# Extra functionality
function random_line() {
	[[ -z $1 || ! -f $1 ]] && return
	VAL=$(dd if=/dev/urandom bs=1 count=4 2>/dev/null | \
		od -t u | head -1 | awk '{print $2}')
	[[ $VAL -eq 0 ]] && VAL=1
	sed -n "$(expr $VAL % $(cat $1 | wc -l))p" $1
}

function qemu() {
	[[ ! -f $1 ]] && return
	qemu-system-x86_64 -name $(basename $1) -enable-kvm \
		-hda $1 -m 2G -smp cpus=2 -daemonize ${@:2}
}
