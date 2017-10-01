#!/usr/bin/env bash
# toggle the bar

# import my color vars
source "/usr/scripts/colors.sh"

# get the pid of the bar
pid=$(pidof "lemonbar")

# set the tmpimg location
tmpimg="/tmp/toggle.png"

# get the screen size
# monw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')

if [ $pid ] ; then
	sed -i "s/<top>70<\/top>/<top>30<\/top>/g" "$HOME/.config/openbox/rc.xml"
	sed -i "s/YPOS=\"70\"/YPOS=\"30\"/" "/usr/scripts/vol.sh"
	openbox --reconfigure
	kill -9 "$pid"
else
	sed -i "s/<top>30<\/top>/<top>70<\/top>/g" "$HOME/.config/openbox/rc.xml"
	sed -i "s/YPOS=\"30\"/YPOS=\"70\"/" "/usr/scripts/vol.sh"
	openbox --reconfigure

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "512x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -x "704" -y "20" &

	sleep ".5s" && /usr/scripts/smpl.sh d &
	sleep "1s" && kill -9 "$(pidof n30f)" &
fi