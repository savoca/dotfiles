#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: xbldec.sh <minimum-val> <decrease-val>"
	exit 1
fi

min=$1
current=$(xbacklight -get)
current_int=${current/\.*}
new=`expr $current_int - $2`

if [ "$new" -lt "$min" ]; then
	xbacklight -set $min
else
	xbacklight -dec $2
fi

