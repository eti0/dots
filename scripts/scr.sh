#!/usr/bin/env bash

# quit on error
set -e

notify-send "screenshot taken"
sleep .2s
maim $HOME/Pictures/Screenshots/$(date +%F-%T).png --hidecursor