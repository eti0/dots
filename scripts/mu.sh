#!/usr/bin/env bash
# download youtube or soundcloud links as mp3
# require scdl (https://github.com/flyingrub/scdl) and youtube-dl (https://github.com/rg3/youtube-dl).

if [ -z "$*" ] ; then
	exit 1
else
	printf "$1" | grep "soundcloud"
		if [ "$?" = "0" ] ; then
			scdl --path "$HOME/Music/sc/" --onlymp3 -l "$@"
		elif [ "$?" = "1" ] ; then
			youtube-dl -x --audio-format "mp3" -o "$HOME/Music/yt/%(title)s.%(ext)s" "$@"
		else
			:
		fi
fi