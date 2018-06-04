#!/usr/bin/env fish


# vars
set song (mpc -f '%file%' | head -1)
set file "/tmp/cover.png"


# funcs
function reset
	printf "\e]20;;100x100+1000+1000\a"
end

function display
	printf "\e]20;$file;75x40+20+0:op=keep-aspect\a"
end

function clean
	rm "$file"
end


# exec
ffmpeg -loglevel "0" \
       -y \
       -i "$HOME/Music/$song" \
       -vf scale="-200:200" \
       "$file"

if test "$argv" = "reset"
	reset
else if test -f "$file"
	display
	clean
else
	reset
end
