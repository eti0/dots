#!/usr/bin/env bash
# toggle the bar

# import my color vars
source "/usr/scripts/colors.sh"

# fetch screen size
width=$(xdotool "getdisplaygeometry" | awk '{print $1;}')
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
ypos=$(expr "$height" - "30")

# get the pid of the bar
pid=$(pidof "lemonbar")

# set the tmpimg location
tmpimg="/tmp/toggle.png"

# get the screen size
# monw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')

if [ $pid ] ; then
	sed -i "s/<bottom>60<\/bottom>/<bottom>30<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
	# sed -i "s/YPOS=\"70\"/YPOS=\"30\"/" "/usr/scripts/vol.sh"
	openbox --reconfigure
	kill -9 "$pid"
else
	sed -i "s/<bottom>30<\/bottom>/<bottom>60<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
	# sed -i "s/YPOS=\"30\"/YPOS=\"70\"/" "/usr/scripts/vol.sh"
	openbox --reconfigure

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "$widthx30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$ypos" &

	sleep ".5s" && /usr/scripts/wbr.sh d &
	sleep "1s" && kill -9 "$(pidof n30f)" &
fi