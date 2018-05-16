#!/usr/bin/env bash
# requires xdotool and ffmpeg.

# vars
crf="20"
fps="30"
enc="h264"
prs="fast"
pxf="yuv420p"
aud="pulse"
aui="default"
com="recording..."
res="$(xdotool "getdisplaygeometry" | sed 's/ /x/')"

# exec
printf "$com\n"
notify-send "$com"
ffmpeg -loglevel 16 \
       -f "x11grab" \
       -framerate "$fps" \
       -s "$res" \
       -i :0.0 \
       -c:v "$enc" \
       -preset "$prs" \
       -crf "$crf" \
       -pix_fmt "$pxf" \
       "$HOME/Videos/$@.mp4"