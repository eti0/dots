#!/usr/bin/env bash
# change the keyboard layout


# vars
file="/tmp/klayout"
current="$(cat "$file")"
lay1="us"
lay2="fr"
lay3="ru"


# exec
if [ -f "$file" ] ; then
	if [ "$current" = "$lay1" ] ; then
		setxkbmap "$lay2"
		printf "$lay2" > "$file"
		notify-send "keyboard layout: $lay2"
	elif [ "$current" = "$lay2" ] ; then
		setxkbmap "$lay3"
		printf "$lay3" > "$file"
		notify-send "keyboard layout: $lay3"
	elif [ "$current" = "$lay3" ] ; then
		setxkbmap "$lay1"
		printf "$lay1" > "$file"
		notify-send "keyboard layout: $lay1"
	else
		notify-send "???"
	fi
else
	notify-send "$file not found. defaulting to the $lay1 layout."
	setxkbmap "$lay1"
	printf "$lay1" > "$file"
fi