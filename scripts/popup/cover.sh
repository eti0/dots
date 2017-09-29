#!/usr/bin/env bash

# vars
csf=`mpc -f %file% | head -1`
csil="/tmp/cover.png"
csbil="/usr/scripts/popup/img/bg.png"

# extract the album art
ffmpeg -loglevel 0 -y -i "$HOME/Music/$csf" -vf scale=-1:200 "$csil"

# display it
sleep ".1s"
popup.sh "img" "$csbil" "10" -p "77" &
sleep ".05s"
n30f -t "coverp" -x "12" -y "42" -c "killall n30f" "$csil"

# delete it
sleep ".25s"
rm "$csil"