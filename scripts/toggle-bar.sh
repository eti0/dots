#!/usr/bin/env fish


# vars
set dir "/usr/scripts"
set img "$dir/img/bar.png"
set pid (pidof lemonbar)


# exec
if test "$pid"
	sed -i "s/<top>$h<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
	pkill -f "n30f -t barborder"
else
	sed -i "s/<top>0<\/top>/<top>$h<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	n30f -t "barborder" \
	     -d "$img"
	wbr &
end