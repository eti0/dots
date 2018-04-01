#!/usr/bin/env bash
# toggle the bar

# vars
tmpimg="/tmp/toggle.png"
pid="$(pidof "lemonbar")"
pid2="$(pidof "tint2")"
width="$(xdotool "getdisplaygeometry" | awk '{print $1;}')"
height="$(xdotool "getdisplaygeometry" | awk '{print $2;}')"
y="0"
h="60"

# import colors
source "/usr/scripts/colors.sh"

# exec
if [ $pid ] ; then
	sed -i "s/<top>$h<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
	kill -9 "$pid2"

	sleep ".5s" && kill -9 "$(pidof n30f)" &
else
	convert -size "$width\ x\ $h" "xc:$background" "$tmpimg"
	n30f "$tmpimg" -y "$y" &

	sed -i "s/<top>0<\/top>/<top>$h<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	sleep ".5s" && wbr &
	sleep ".5s" && tint2 -c "$HOME/.config/tint2/slim" &

	sleep "1.5s" && kill -9 "$(pidof n30f)" &
fi