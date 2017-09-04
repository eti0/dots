#!/usr/bin/env bash

devices="$(xsetwacom --list devices | grep -o "Wacom" | head -n1)"

if [ "$devices" == "Wacom" ] ; then
	xsetwacom set "Wacom Bamboo Connect Pen stylus" Rotate half
	xsetwacom set "Wacom Bamboo Connect Pen eraser" Rotate half
	printf "done! \n"
	exit 0
else
	printf "no matching devices found \n"
	exit 1
fi