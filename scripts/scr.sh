#!/usr/bin/env bash

# quit on error
set -e

maim $HOME/Pictures/Screenshots/$(date +%F-%T).png --hidecursor
notify-send "screenshot taken"