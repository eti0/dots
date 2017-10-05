#!/usr/bin/env bash
# small xbps alternative

if [ "$1" = "i" ] ; then
	printf "\e[8;40;90t"
	/usr/scripts/center.sh
	sudo xbps-install "${@:2}"
elif [ "$1" = "s" ] ; then
	printf "\e[8;40;90t"
	/usr/scripts/center.sh
	sudo xbps-query -Rs "${@:2}"
elif [ "$1" = "r" ] ; then
	printf "\e[8;40;90t"
	/usr/scripts/center.sh
	sudo xbps-remove "${@:2}"
else
	echo "no arguments given"
	exit 1
fi