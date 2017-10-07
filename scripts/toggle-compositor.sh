#!/usr/bin/env bash
# toggle the compositor

# get the pid of the bar
pid=$(pidof compton)

if [ $pid ] ; then
	kill -9 $pid
else
	compton -Ccf &
	disown
fi