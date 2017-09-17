# record the screen

function screencord
    notify-send "recording has started"
    ffmpeg -f "x11grab" -framerate "50" -s "1920x1080" -i :0.0 -c:v "libx264" -preset "faster" -crf "22" ~/Videos/$argv.mp4
end