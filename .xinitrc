if (xrandr | grep "HDMI-0 connected" > /dev/null)
then
	xrandr --output LVDS --off
	xrandr --output HDMI-0 --mode 1600x900
fi
. /home/savoca/.fehbg
compton --refresh-rate 60 --vsync opengl-swc &
sleep 2s &
exec i3
