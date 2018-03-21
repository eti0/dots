#!/usr/bin/env bash
# toggle the bar

# import my color vars
source "/usr/scripts/colors.sh"

# fetch screen size
width=$(xdotool "getdisplaygeometry" | awk '{print $1;}')
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
ypos="0"

# get the pid of the bar
pid=$(pidof "lemonbar")

# set the tmpimg location
tmpimg="/tmp/toggle.png"

# execute
if [ $pid ] ; then
	# change openbox margins
	sed -i "s/<top>30<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "$width x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$ypos" &

	# kill the bar
	kill -9 "$pid"

	# kill n30f
	sleep ".5s" && kill -9 "$(pidof n30f)" &
else
	# change openbox margins
	sed -i "s/<top>0<\/top>/<top>30<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "$width x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$ypos" &

	# start the bar
	sleep ".5s" && /usr/scripts/wbr.sh &

	# kill n30f
	sleep "1s" && kill -9 "$(pidof n30f)" &
fi