#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"
font="lime"
mw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')


# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill "white" \
		-font "$font" \
		+antialias \
		-pointsize "10" \
		label:"$(date "+%d %B %Y\n" && cal -m | tail -n7)" \
		"$cil"

# display it
popup "" "$(expr "$mw" - "270")" &
sleep ".05s"
n30f -x "$(expr "$mw" - "200")" \
	 -y "150" \
	 -c "killall n30f" "$cil"

# delete it
sleep ".2s"
rm "$cil"