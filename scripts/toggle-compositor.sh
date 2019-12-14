#!/usr/bin/env fish


# vars
set pid (pidof picom)


# exec
if test "$pid"
    kill -9 "$pid"
    notify-send "compositor disabled"
else
    picom --experimental-backends &
    notify-send "compositor enabled"
end