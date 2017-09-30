#!/usr/bin/env bash

notify-send "screenshot taken"
sleep .2s
maim $HOME/Pictures/Screenshots/$(date +%F-%T).png --hidecursor