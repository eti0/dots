#!/usr/bin/env fish


# vars
set song (mpc -f '%file%' | head -1)
set cover "/tmp/cover.png"


# exec
ffmpeg -loglevel "0" \
	   -y \
	   -i "$HOME/Music/$song" \
	   -vf scale="-200:200" "$cover"

popup "$cover" "30"

sleep ".1"
rm "$cover"