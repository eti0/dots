#!/usr/bin/env bash
# toggle the bar

# import my color vars
source "/usr/scripts/colors.sh"

# get the pid of the bar
pid=$(pidof "lemonbar")

# set the tmpimg location
tmpimg="/tmp/toggle.png"
# get the screen size
monw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')

if [ $pid ] ; then
	sed -i "s/<top>60<\/top>/<top>30<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure
	kill -9 "$pid"
else
	sed -i "s/<top>30<\/top>/<top>60<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "$monw x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" &

	/usr/scripts/bar.sh &

	sleep ".5s" && kill -9 "$(pidof n30f)"
fi