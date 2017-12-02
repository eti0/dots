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

# execute
if [ $pid ] ; then
	convert -size "$width x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$ypos" &

	# kill n30f
	sleep ".3s" && kill -9 "$(pidof n30f)" &
	
	# change openbox margins
	sed -i "s/<bottom>60<\/bottom>/<bottom>30<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	# change dunst placement
	sed -i "s/-50\"/-20\"/g" "$HOME/.config/dunstrc"
	kill -9 "$(pidof dunst)"

	# adapt center.sh
	sed -i "s/- 20/- 0/g" "/usr/scripts/center.sh"

	# kill the bar
	kill -9 "$pid"
else
	# change openbox margins
	sed -i "s/<bottom>30<\/bottom>/<bottom>60<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	# change dunst placement
	sed -i "s/-20\"/-50\"/g" "$HOME/.config/dunstrc"
	kill -9 "$(pidof dunst)"

	# adapt center.sh
	sed -i "s/- 0/- 20/g" "/usr/scripts/center.sh"

	# since lemonbar is ugly on startup (empty spaces)
	# i use n30f to display a png until the bar is done starting
	convert -size "$width x30" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$ypos" &

	# start the bar
	sleep ".5s" && /usr/scripts/wbr.sh d &

	# kill n30f
	sleep "1s" && kill -9 "$(pidof n30f)" &
fi