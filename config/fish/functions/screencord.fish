# record the screen

function screencord
    printf "recording...\n"
    ffmpeg -f "alsa" -i "default" -loglevel "16" -f "x11grab" -framerate "60" -s "1920x1080" -i :0.0 -c:v "hevc_nvenc" "$HOME/Videos/$argv.mp4"
end