#!/usr/bin/env fish


# vars
set pid (pidof stalonetray)


# exec
if test "$pid"
	killall "stalonetray"
else
	stalonetray &
end