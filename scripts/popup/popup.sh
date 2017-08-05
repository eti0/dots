#!/usr/bin/env bash

# vars
pointer="/usr/scripts/popup/img/pointer.png"

# launch urxvt and nmtui
if [ "$1" == "img" ] ; then
	n30f -t "popup" -x "$3" -y "40" -c "pkill -f 'pointer' && pkill -f 'n30f -t popup'" "$2" &
else [ "$1" == "term" ]
	urxvtc -name "popup" -g "$3" -bd "#ffffff" -b "2" -e "$2" &
fi
    
# pointer
if [ "$4" == "-p" ] ; then
	n30f -t "pointer" -x "$5" -y "34" -c "pkill -f 'n30f -t popup' && pkill -f '$2' && pkill -f 'pointer'" "$pointer"
else
	exit
fi