function vb0
    # vars
    set name (basename "$argv[1]" | sed "s/\..*//")
    
    # exec
    ffmpeg -v "quiet" -stats -i "$argv[1]" -f "mp3" -q:a "0" $name.mp3
end