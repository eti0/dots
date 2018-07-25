#!/usr/bin/env fish


# vars
set dir "/usr/scripts"
set img "$dir/img/underline.png"
set pid (pidof lemonbar)

set h 40


# exec
if test "$pid"
	sed -i "s/<top>$h<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
    pkill -f "n30f -t underline"
else
	sed -i "s/<top>0<\/top>/<top>$h<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

    wbr &
    n30f -t "underline" \
    -y "40" \
    "$img" &
end