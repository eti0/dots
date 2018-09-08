#!/usr/bin/env fish


# vars
set pid (pidof lemonbar)
set h 35


# exec
if test "$pid"
	sed -i "s/<left>$h<\/left>/<left>0<\/left>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

	kill -9 "$pid"
else
	sed -i "s/<left>0<\/left>/<left>$h<\/left>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure

    wbr
end