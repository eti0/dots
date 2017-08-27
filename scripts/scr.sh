#!/usr/bin/env bash

maim ~/Pictures/Screenshots/$(date +%F-%T).png --hidecursor

notify-send "screenshot taken"