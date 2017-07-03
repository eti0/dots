# record the screen

function screenwebm
	ffmpeg -f "x11grab" -framerate "30" -s "1366x768" -i :0.0 -c:v "vp9" ~/Videos/$argv.webm
end