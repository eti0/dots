#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"

# convert the output to png
convert -background "#232e2f" \
		-fill white \
		-font "erusfont" \
		+antialias \
		-pointsize 11 \
		label:"$(date "+%d %B %Y" && cal | tail -n7)" \
		"$cil"

# display it
popup.sh "img" "$bg" "565" -p "662" &
sleep "0.01s"
n30f -t "popup" -x "610" -y "100" -c "pkill -f 'n30f -t popup' && pkill -f 'pointer'" "$cil"

# delete it
sleep "1s"
rm "$cil"