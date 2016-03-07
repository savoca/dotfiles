#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <up|down>"
	exit 1
fi

KBL=/sys/class/backlight/gmux_backlight/
CUR=`cat $KBL/brightness`
MAX=1000

if [ "$1" = "up" ]; then
	NEW=`expr ${CUR} + 100`
	if [ "$NEW" -gt "$MAX" ]; then
		echo $MAX > $KBL/brightness
	else
		echo $NEW > $KBL/brightness
	fi
elif [ "$1" = "down" ]; then
	NEW=`expr ${CUR} - 100`
	if [ "$NEW" -lt "10" ]; then
		echo 10 > $KBL/brightness
	else
		echo $NEW > $KBL/brightness
	fi
elif [ "$1" = "get" ]; then
	echo $CUR
fi
