# HW Specific
BOARD=$(cat /sys/devices/virtual/dmi/id/board_name)

# HP dv6-6170us
if [ "$BOARD" = "1657" ]; then
	if (xrandr | grep "HDMI1 connected" > /dev/null) then
		xrandr --output LVDS1 --off
		xrandr --output HDMI1 --mode 1920x1080
	fi
fi

# Acer C720
if [ "$BOARD" = "Peppy" ]; then
	if (xrandr | grep "HDMI1 connected" > /dev/null) then
		xrandr --output eDP1 --off
		xrandr --output HDMI1 --mode 1920x1080
	fi
	xbindkeys -f ~/.xbindkeysrc-c720
fi

# CM Storm Quickfire Rapid-i Keyboard
if (xinput | grep "CM Storm Quickfire" > /dev/null) then
	xbindkeys -f ~/.xbindkeysrc-quickfire
fi

# The rest!
. /home/savoca/.fehbg
compton -b
exec i3
