#!/usr/bin/env bash

# vars
bg="/usr/scripts/popup/img/bg.png"
wtri="/tmp/wtr.png"
# wtr=$(weather -qm --headers="Temperature,Sky Conditions" "EGSC")
wtr=$(curl -Sl "http://wttr.in/Bordeaux?0QT")

# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill white \
		-font "erusfont" \
		-pointsize "11" \
		-format "200x200" \
		+antialias \
		label:"$wtr" \
		"$wtri"

# display it
popup.sh "img" "$bg" "565" -p "662" &
sleep "0.01s"
n30f -t "popup" -x "610" -y "102" -c "pkill -f 'n30f -t popup' && pkill -f 'pointer'" "$wtri"