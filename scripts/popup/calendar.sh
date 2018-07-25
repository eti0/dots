#!/usr/bin/env bash


# vars
dir="/usr/scripts/popup"
file="/tmp/calendar.png"
background="$dir/img/bg.png"
font="lime"
monitorwidth="$(xdotool getdisplaygeometry | awk '{print $1;}')"
x="$(expr $monitorwidth - 260)"
y="59"


# exec
pkill -f "n30f -t calendar"

convert -background "rgba(0,0,0,0)" \
	-fill "#071d22" \
	-font "$font" \
	+antialias \
	-pointsize "10" \
	label:"$(date "+%d %B %Y" && printf '\n' && cal -m1 | tail -n7)" \
	"$file"

n30f -t calendar_background \
     -x "$x" \
     -y "$y" \
     -c "pkill -f 'n30f -t calendar'" \
     "$background" &

n30f -t calendar \
     -x "$(expr $x + 70)" \
     -y "$(expr $y + 85)" \
     -c "pkill -f 'n30f -t calendar'" \
     "$file" &

n30f -t "popup-arrow" \
     -x "$(expr $x + 180)" \
     -y "$(expr $y - 19)" \
     -c "pkill -f 'n30f -t calendar'" \
     "/usr/scripts/popup/img/arrow.png"


# clean
rm "$file"
