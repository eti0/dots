#!/usr/bin/env bash
# toggle the pager

pid="$(pidof "netwmpager")"

if [ "$pid" ] ; then
	kill -9 "$pid"
else
	netwmpager &
	disown
fi