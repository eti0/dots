function x264
    # vars
    set name (basename "$argv[1]" | sed "s/\..*//")
    set preset "veryfast"
    set rate "25"

    # exec
    ffmpeg -v "quiet" -stats -i "$argv[1]" -crf "$rate" -preset "$preset" -c:v "libx264" -threads "4" $name.x264.mp4
end