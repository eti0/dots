#!/usr/bin/env bash
# toggle the compositor

# get the pid of compton
pid=$(pidof compton)

if [ $pid ] ; then
	kill -9 $pid
	notify-send "compositor disabled"
else
	compton -Ccf &
	disown
	notify-send "compositor enabled"
fi