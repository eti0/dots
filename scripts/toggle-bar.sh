#!/usr/bin/env fish


# vars
set tmpimg "/tmp/toggle.png"
set pid (pidof lemonbar)
set geo (xdotool getdisplaygeometry)
set width (printf $geo | awk '{print $1;}')
set height (printf $geo | awk '{print $2;}')
set y "0"
set h "40"


# exec
if test "$pid"
	sed -i "s/<top>$h<\/top>/<top>0<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
else
	sed -i "s/<top>0<\/top>/<top>$h<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	wbr &
end