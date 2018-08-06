#!/usr/bin/env bash


# vars
dir="/usr/scripts/popup"
file="/tmp/calendar.png"
background="$dir/img/bg.png"
font="Monaco"
monitorwidth="$(xdotool getdisplaygeometry | awk '{print $1;}')"
x="$(expr $monitorwidth - 260)"
y="60"


# exec
pkill -f "n30f -t calendar"

convert -background "rgba(0,0,0,0)" \
	-fill "#062228" \
	-font "$font" \
	-pointsize "10" \
	label:"$(date "+%d %B %Y" && printf '\n' && cal -m1 | tail -n7)" \
	"$file"

n30f -t calendar_background \
     -x "$x" \
     -y "$y" \
     -c "pkill -f 'n30f -t calendar'" \
     "$background" &

n30f -t calendar \
     -x "$(expr $x + 65)" \
     -y "$(expr $y + 75)" \
     -c "pkill -f 'n30f -t calendar'" \
     "$file" &

n30f -t "popup-arrow" \
     -x "$(expr $x + 180)" \
     -y "$(expr $y - 20)" \
     -c "pkill -f 'n30f -t calendar'" \
     "/usr/scripts/popup/img/arrow.png"


# clean
rm "$file"
