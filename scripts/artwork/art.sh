#!/usr/bin/env bash


# vars
csf=`mpc -f %file% | head -1`
csil="/tmp/mpdimg.png"
csbil="/usr/scripts/artwork/bg.png"
pointeril="/usr/scripts/artwork/pointer.png"

# extract the album art
ffmpeg -loglevel 0 -y -i "/home/eti/Music/$csf" -vf scale=-1:200 "$csil"

# pointer
n30f -x "67" -y "34" -c "killall n30f" "$pointeril" &

# background
n30f -x "10" -y "40" -c "killall n30f" "$csbil" &

# album art
n30f -x "12" -y "42" -c "killall n30f" "$csil"

# delete the album art
rm "$csil"