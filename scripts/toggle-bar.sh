#!/usr/bin/env bash
# toggle the bar

source "/usr/scripts/colors.sh"

pid=$(pidof "lemonbar")
tmpimg="/tmp/toggle.png"
monw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')

if [ $pid ]; then
	sed -i "s/<top>60<\/top>/<top>30<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure
	kill -9 "$pid"
else
	sed -i "s/<top>30<\/top>/<top>60<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure
	convert -size "$monw x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" &
	/usr/scripts/bar.sh &
	sleep ".5s" && kill -9 "$(pidof n30f)"
fi