#!/usr/bin/env fish


# vars
set pid (pidof lemonbar)
set h 35


# exec
if test "$pid"
	sed -i "s/<top>$h<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
else
	sed -i "s/<top>0<\/top>/<top>$h<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

    wbr
end