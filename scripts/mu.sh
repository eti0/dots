#!/usr/bin/env fish


if test -z "$argv"
	exit 1
else
	printf "$argv" | grep "soundcloud" > "/dev/null"
		if test "$status" = "0"
			scdl --path "$HOME/Music/mu/sc/" --onlymp3 -l "$argv"
		else if test "$status" = "1"
			youtube-dl -x --audio-format "mp3" -o "$HOME/Music/mu/yt/%(title)s.%(ext)s" "$argv"
		else
			#
		end
end