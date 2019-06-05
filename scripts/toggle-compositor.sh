#!/usr/bin/env fish


# vars
set pid (pidof compton)


# exec
if test "$pid"
    kill -9 "$pid"
    notify-send "compositor disabled"
else
    compton &
    disown
    notify-send "compositor enabled"
end