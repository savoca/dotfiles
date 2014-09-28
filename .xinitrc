if (xrandr | grep "HDMI1 connected" > /dev/null)
then
	xrandr --output LVDS1 --off
	xrandr --output HDMI1 --mode 1920x1080
fi
. /home/savoca/.fehbg
compton -b
sleep 2s &
exec i3
