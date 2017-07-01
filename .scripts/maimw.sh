#!/bin/bash

maim -s --hidecursor ~/Pictures/Screenshots/$(date +%F-%T).png

notify-send "window screenshot taken"