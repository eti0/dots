#!/usr/bin/env bash
# xbps shortcuts

clean() {
	printf "\e[8;40;90t"
	/usr/scripts/center.sh
}

if [ "$1" = "i" ] ; then
	sudo xbps-install "${@:2}"
elif [ "$1" = "s" ] ; then
	sudo xbps-query -Rs "${@:2}"
elif [ "$1" = "r" ] ; then
	sudo xbps-remove "${@:2}"
else
	printf "usage: xbp [i (install) | s (search) | r (remove)]\n"
	exit 1
fi