#!/usr/bin/env fish
# change the keyboard layout


# vars
set file "/tmp/klayout"
set current (cat "$file")
set lay1 "us"
set lay2 "fr"
set lay3 "ru"


# exec
if test -f "$file"
	if test "$current" = "$lay1"
		setxkbmap "$lay2"
		printf "$lay2" > "$file"
		notify-send "keyboard layout: $lay2"
	else if test "$current" = "$lay2"
		setxkbmap "$lay3"
		printf "$lay3" > "$file"
		notify-send "keyboard layout: $lay3"
	else if test "$current" = "$lay3" 
		setxkbmap "$lay1"
		printf "$lay1" > "$file"
		notify-send "keyboard layout: $lay1"
	else
		notify-send "???"
	end
else
	notify-send "$file not found. defaulting to the $lay1 layout."
	setxkbmap "$lay1"
	printf "$lay1" > "$file"
end