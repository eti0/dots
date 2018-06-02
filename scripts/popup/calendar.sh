#!/usr/bin/env bash


# vars
dir="/usr/scripts/popup"
file="/tmp/calendar.png"
background="$dir/img/bg.png"
font="lime"
monitorwidth="$(xdotool getdisplaygeometry | awk '{print $1;}')"
x="$(expr $monitorwidth - 270)"
y="70"


# exec
pkill -f "n30f -t calendar"

convert -background "rgba(0,0,0,0)" \
	-fill "white" \
	-font "$font" \
	+antialias \
	-pointsize "10" \
	label:"$(date "+%d %B %Y \n" && cal -m | tail -n7)" \
	"$file"

n30f -t calendar_background \
     -x "$x" \
     -y "$y" \
     -c "pkill -f 'n30f -t calendar'" \
     "$background" &

n30f -t calendar \
     -x "$(expr $x + 70)" \
     -y "$(expr $y + 80)" \
     -c "pkill -f 'n30f -t calendar'" \
     "$file"


# clean
rm "$file"
