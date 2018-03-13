#!/usr/bin/env bash

# quit on error
set -e

maim --hidecursor "$HOME/Pictures/Screenshots/$(date +%F-%T).png"
notify-send "screenshot taken"