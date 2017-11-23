#!/usr/bin/env bash

# quit on error
set -e

# vars
csf=$(mpc -f %file% | head -1)
csil="/tmp/cover.png"
csbil="/usr/scripts/popup/img/bg.png"
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
ypos=$(expr "$height" - "242")

# extract the album art
ffmpeg -loglevel 0 -y -i "$HOME/Music/$csf" -vf scale=-200:200 "$csil"

# display it
popup /tmp/cover.png "6" -p "97"

# delete it
sleep ".25s"
rm "$csil"