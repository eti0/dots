function webm
    # vars
    set name (basename "$argv[1]" | sed "s/\..*//")
    set rate "3M"

    # exec
    ffmpeg -v "quiet" -stats -i "$argv[1]" -minrate "$rate" -maxrate "$rate" -b:v "$rate" -c:v "libvpx" -threads "4" $name.webm
end