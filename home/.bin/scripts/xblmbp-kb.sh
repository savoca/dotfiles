#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <up|down>"
	exit 1
fi

KBL=/sys/class/leds/smc\:\:kbd_backlight/
CUR=`cat $KBL/brightness`
MAX=`cat $KBL/max_brightness`

if [ "$1" = "up" ]; then
	NEW=`expr ${CUR} + 25`
	if [ "$NEW" -gt "$MAX" ]; then
		echo $MAX > $KBL/brightness
	else
		echo $NEW > $KBL/brightness
	fi
elif [ "$1" = "down" ]; then
	NEW=`expr ${CUR} - 25`
	if [ "$NEW" -lt "0" ]; then
		echo 0 > $KBL/brightness
	else
		echo $NEW > $KBL/brightness
	fi
elif [ "$1" = "get" ]; then
	echo $CUR
fi
