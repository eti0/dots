#!/usr/bin/env bash

# vars
name="$(basename $1)"

# exec
convert "$1"  \( +clone -background "black" -shadow "5%5x3+0+2" \) +swap -background "transparent" -layers merge +repage "/home/eti/Pictures/Screenshots/shadow/shadow_$name"