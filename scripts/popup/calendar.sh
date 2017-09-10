#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"

# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill white \
		-font "t0-11-uni" \
		+antialias \
		-pointsize 11 \
		label:"$(date "+%d %B %Y\n" && cal | tail -n7)" \
		"$cil"

# display it
sleep ".1s"
popup.sh "img" "$bg" "858" -p "954" &
sleep ".05s"
n30f -t "popup" -x "897" -y "96" -c "pkill -f 'n30f -t popup' && pkill -f 'n30f -t pointer'" "$cil"
pkill -f 'n30f -t pointer'

# delete it
sleep ".2s"
rm "$cil"