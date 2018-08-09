#!/usr/bin/env fish


# vars
set crf "20"
set fps "30"
set enc "h264"
set prs "fast"
set pxf "yuv420p"
set aud "alsa"
set aui "default"
set com "recording..."
set res (xdotool getdisplaygeometry | sed 's/ /x/')


# exec
printf "$com\n"
ffmpeg -loglevel "16" \
       # -f "$aud" \
       # -i "$aui" \
       -f "x11grab" \
       -framerate "$fps" \
       -s "$res" \
       -i ":0.0" \
       -c:v "$enc" \
       -preset "$prs" \
       -crf "$crf" \
       -pix_fmt "$pxf" \
       "$HOME/Videos/$argv.mp4"
