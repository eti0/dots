#!/usr/bin/env fish


# vars
set pid (pidof lemonbar)
set h 35


# exec
if test "$pid"
    # sed -i "s/<bottom>$h<\/bottom>/<bottom>0<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
    openbox --reconfigure

    kill -9 "$pid"
else
    # sed -i "s/<bottom>0<\/bottom>/<bottom>$h<\/bottom>/g" "$HOME/.config/openbox/rc.xml"
    openbox --reconfigure

    wbr
end