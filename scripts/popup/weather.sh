#!/usr/bin/env bash

# vars
bg="/usr/scripts/popup/img/bg.png"
wtri="/tmp/wtr.png"
wtr=$(curl -Sl "http://wttr.in/Bordeaux?0QT")

# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill white \
		-font "t0-11-uni" \
		+antialias \
		-pointsize 11 \
		label:"$wtr" \
		"$wtri"

# display it
sleep ".1s"
popup.sh "img" "$bg" "581" -p "678" &
sleep ".05s"
n30f -t "popup" -x "624" -y "96" -c "pkill -f 'n30f -t popup' && pkill -f 'n30f -t pointer'" "$wtri"
pkill -f "n30f -t pointer"

# delete it
sleep ".2s"
rm "$wtri"