#!/usr/bin/env bash
# xbps shortcuts

if [ "$1" = "i" ] ; then
	xbps-install "${@:2}"
elif [ "$1" = "s" ] ; then
	xbps-query -Rs "${@:2}"
elif [ "$1" = "r" ] ; then
	xbps-remove "${@:2}"
else
	printf "you didn't provide any argument you dumbfuck.
usage: xbp [options]
options:
  i (install)
  s (search)
  r (remove)\n"
	exit 1
fi