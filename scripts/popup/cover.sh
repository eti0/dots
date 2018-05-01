#!/usr/bin/env bash

# quit on error
set -e

# vars
csf=$(mpc -f "%file%" | head -1)
csil="/tmp/cover.png"
csbil="/usr/scripts/popup/img/bg.png"

# extract the album art
ffmpeg -loglevel "0" \
	   -y \
	   -i "$HOME/Music/$csf" \
	   -vf scale="-200:200" "$csil"

# display it
popup "$csil" "20"

# delete it
sleep ".1"
rm "$csil"