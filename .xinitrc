xrandr --output LVDS --off
xrandr --output HDMI-0 --mode 1600x900
. /home/savoca/.fehbg
compton --refresh-rate 60 --vsync opengl-swc &
sleep 2s &
exec i3
