#!/bin/bash

# Wait for a little while after logind to let everything settle
sleep 3

# Whatever you need here

## Apple keyboard backlight control
chmod 0666 /sys/class/leds/smc\:\:kbd_backlight/brightness

## 2015 rMBP (and maybe others) gmux_backlight control
setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
chmod 0666 /sys/class/backlight/gmux_backlight/brightness
echo 1000 > /sys/class/backlight/gmux_backlight/brightness
