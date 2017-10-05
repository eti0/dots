#!/usr/bin/env bash

# quit on error
set -e

maim -s --hidecursor "$HOME/Pictures/Screenshots/$(date +%F-%T).png"

if [ "$?" == "1"  ] ; then
	:
else
	notify-send "window screenshot taken"
fi