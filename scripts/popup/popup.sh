#!/usr/bin/env fish


# vars
set scriptdir "/usr/scripts"
set background "$scriptdir/popup/img/bg.png"
set file "$argv[1]"
set tmpf "/tmp/popup.png"
set ypos "70"
set xpos "$argv[2]"


# funcs
function resize
	convert "$file" \
			-resize "200x200!" \
			"$tmpf"
end

function display_background
	n30f -x "$xpos" \
		 -y "$ypos" \
		 -c "killall n30f" \
		 "$background" &
end

function display_image
	n30f -x (math $xpos + 20) \
		 -y (math $ypos + 20) \
		 -c "killall n30f" \
		 "$tmpf" &
end

function clean
	rm "$tmpf"
end


# exec
if test -z "$argv"
	printf "usage:\npopup: [file] [position]\n"
else
	resize
	display_background
	display_image
	sleep "1s"
	clean
end