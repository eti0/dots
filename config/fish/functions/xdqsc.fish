function xdqsc
    ffmpeg -i "$argv[1]" -c:v "libx265" -preset "veryfast" -crf "30" -c:a "aac" -b:a "128k" "$argv[2]"
end