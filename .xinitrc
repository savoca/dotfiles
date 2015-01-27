if (xrandr | grep "HDMI1 connected" > /dev/null) then
	xrandr --output LVDS1 --off
	xrandr --output HDMI1 --mode 1920x1080
fi

if (xinput | grep "CM Storm Quickfire" > /dev/null) then
	xbindkeys -f ~/.xbindkeysrc-quickfire
else
	xbindkeys -f ~/.xbindkeysrc-c720
fi

. /home/savoca/.fehbg
compton -b
exec i3
