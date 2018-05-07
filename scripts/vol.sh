#!/usr/bin/env bash
# vars
sink="$(pactl info | grep -oP "(?<=Default Sink: ).*(?=)")"

# exec
case "$1" in
	"i")
		pactl set-sink-volume "$sink" +"$2"%
		;;
	"d")
		pactl set-sink-volume "$sink" -"$2"%
		;;
	"t")
		pactl set-sink-mute "$sink" "toggle"
		;;
	*)
		printf "wrong argument."
		exit "1"
		;;
esac