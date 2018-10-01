function hevc
    # vars
    set name (basename "$argv[1]" | sed "s/\..*//")
    set rate "25"

    # exec
    ffmpeg -v "quiet" -stats -i "$argv[1]" -crf "$rate" -c:v "libx265" -threads "4" $name.hevc.mp4
end