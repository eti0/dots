#!/usr/bin/env bash


# vars
csf=`mpc -f %file% | head -1`
csil="/tmp/mpdimg.png"
csbil="/usr/scripts/artwork/bg.png"


# exec
ffmpeg -loglevel 0 -y -i "/home/eti/Music/$csf" -vf scale=-1:200 "$csil"

n30f -x "10" -y "40" -c "killall n30f" "$csbil" &
n30f -x "12" -y "48" -c "killall n30f" "$csil"

rm "$csil"