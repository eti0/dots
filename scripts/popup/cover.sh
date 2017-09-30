#!/usr/bin/env bash

# vars
csf=`mpc -f %file% | head -1`
csil="/tmp/cover.png"
csbil="/usr/scripts/popup/img/bg.png"

# extract the album art
ffmpeg -loglevel 0 -y -i "$HOME/Music/$csf" -vf scale=-1:200 "$csil"

# display it
if [ "$1" == "d" ] ; then
	sleep ".1s"
	popup.sh "img" "$csbil" "681" -p "780" &
	sleep ".05s"
	n30f -t "coverp" -x "683" -y "58" -c "killall n30f" "$csil"
elif [ "$1" == "l" ] ; then
	sleep ".1s"
	popup.sh "img" "$csbil" "408" -p "503" &
	sleep ".05s"
	n30f -t "coverp" -x "410" -y "58" -c "killall n30f" "$csil"	
else
	:
fi

# delete it
sleep ".25s"
rm "$csil"