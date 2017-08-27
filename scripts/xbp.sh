#!/usr/bin/env bash
# small xbps alternative

if [ "$1" = "i" ] ; then
	sudo xbps-install "${@:2}"
elif [ "$1" = "s" ] ; then
	sudo xbps-query -Rs "${@:2}"
elif [ "$1" = "r" ] ; then
	sudo xbps-remove "${@:2}"
else
	echo "no arguments given"
	exit 1
fi