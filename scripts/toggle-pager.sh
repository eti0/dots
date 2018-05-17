#!/usr/bin/env fish


# vars
set pid (pidof "netwmpager")


# exec
if test "$pid"
	kill -9 "$pid"
else
	netwmpager &
	disown
end