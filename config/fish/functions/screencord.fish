# record the screen

# vars
set res (xdotool "getdisplaygeometry" | sed 's/ /x/')
set comment "recording...\n"
set audioint default
set audio alsa
set enc libx264
set pres veryfast
set crf 20
set fps 50

# exec
function screencord
    printf $comment
    ffmpeg -loglevel 16 -f $audio -i $audioint -f x11grab -framerate $fps -s $res -i :0.0 -c:v $enc -preset $pres -crf $crf $HOME/Videos/$argv.mp4
end