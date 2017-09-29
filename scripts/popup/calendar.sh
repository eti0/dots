#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"

# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill white \
		-font "kakwafont-12-n" \
		+antialias \
		-pointsize 12 \
		label:"$(date "+%d %B %Y\n" && cal | tail -n7)" \
		"$cil"

# display it
sleep ".1s"
popup.sh "img" "$bg" "858" -p "954" &
sleep ".05s"
n30f -t "popup" -x "898" -y "95" -c "killall n30f" "$cil"
pkill -f 'n30f -t pointer'

# delete it
sleep ".2s"
rm "$cil"