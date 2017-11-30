#!/usr/bin/env bash
# toggle the system tray

# get the pid of stalonetray
pid=$(pidof stalonetray)

if [ $pid ] ; then
	killall stalonetray
else
	stalonetray &
fi