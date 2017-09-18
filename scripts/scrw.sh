#!/usr/bin/env bash

maim -s --hidecursor "$HOME/Pictures/Screenshots/$(date +%F-%T).png"

if [ "$?" == "1"  ] ; then
	:
else
	notify-send "window screenshot taken"
fi