function record
    # vars
    set crf "0"
    set fps "50"
    set enc "libx264"
    set prs "ultrafast"
    set pxf "yuv420p"
    set aud "alsa"
    set aui "default"
    set com "recording..."
    set res (xdotool getdisplaygeometry | sed 's/ /x/')

    # exec
    if test "$argv[1]" = "-a"
        printf "$com\n"
        ffmpeg -loglevel "16" \
               -f "$aud" \
               -i "$aui" \
               -f "x11grab" \
               -framerate "$fps" \
               -s "$res" \
               -i ":0.0" \
               -c:v "$enc" \
               -preset "$prs" \
               -crf "$crf" \
               -pix_fmt "$pxf" \
               "$HOME/Videos/$argv[2].mp4"
    else
        printf "$com\n"
        ffmpeg -loglevel "16" \
               -f "x11grab" \
               -framerate "$fps" \
               -s "$res" \
               -i ":0.0" \
               -c:v "$enc" \
               -preset "$prs" \
               -crf "$crf" \
               -pix_fmt "$pxf" \
               "$HOME/Videos/$argv.mp4"
    end
end