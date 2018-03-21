#!/usr/bin/env bash
# vars
sink="0"

# exec
if [ "$1" == "i" ] ; then
	pactl set-sink-volume "$sink" +"$2"%
elif [ "$1" == "d" ] ; then
	pactl set-sink-volume "$sink" -"$2"%
elif [ "$1" == "t" ] ; then
	pactl set-sink-mute "$sink" "toggle"
else
	printf "wrong argument."
	exit "1"
fi