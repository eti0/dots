#!/usr/bin/env fish


# vars
set sink (pactl info | grep -oP "(?<=Default Sink: ).*(?=)")


# exec
switch "$argv[1]"
	case "i"
		pactl set-sink-volume "$sink" +"$argv[2]"%
	case "d"
		pactl set-sink-volume "$sink" -"$argv[2]"%
	case "t"
		pactl set-sink-mute "$sink" "toggle"
	case "*"
		printf "wrong argument."
		exit "1"
end