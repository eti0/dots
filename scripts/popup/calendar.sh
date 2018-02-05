#!/usr/bin/env bash

# vars
cil="/tmp/calendar.png"
bg="/usr/scripts/popup/img/bg.png"
font="kakwafont-12-n"
mw=$(xdotool "getdisplaygeometry" | awk '{print $1;}')
mh=$(xdotool "getdisplaygeometry" | awk '{print $2;}')


# convert the output to png
convert -background "rgba(0,0,0,0)" \
		-fill "white" \
		-font "$font" \
		+antialias \
		-pointsize 12 \
		label:"$(date "+%d %B %Y\n" && cal -m| tail -n7)" \
		"$cil"

# display it
popup "" "$(expr "$mw" - "215")" -p "175" &
sleep ".05s"
n30f -x "$(expr "$mw" - "168")" -y "$(expr "$mh" - "190")" -c "killall n30f" "$cil"

# delete it
sleep ".2s"
rm "$cil"