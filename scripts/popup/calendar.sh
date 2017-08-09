#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"

# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill white \
		-font "erusfont" \
		+antialias \
		-pointsize 11 \
		label:"$(date "+%d %B %Y\n" && cal | tail -n7)" \
		"$cil"

# display it
popup.sh "img" "$bg" "581" -p "678" &
sleep "0.01s"
n30f -t "popup" -x "624" -y "96" -c "pkill -f 'n30f -t popup' && pkill -f 'n30f -t pointer'" "$cil"
pkill -f 'n30f -t pointer'

# delete it
sleep ".2s"
rm "$cil"