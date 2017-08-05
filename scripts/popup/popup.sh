#!/usr/bin/env bash
# usage:
# popup.sh [type] [program / file] [ geometry / placement ] -p [ pointer location ]
# e.g.: popup.sh "term" "nmtui" "60x25+1056+42"
# popup.sh "img" "rice.png" "10" -p "24"

# vars
pointer="/usr/scripts/popup/img/pointer.png"

# launch urxvt and nmtui
if [ "$1" == "img" ] ; then
	n30f -t "popup" -x "$3" -y "40" -c "pkill -f 'pointer' && pkill -f 'n30f -t popup'" "$2" &
else [ "$1" == "term" ]
	urxvtc -name "popup" -g "$3" -bd "white" -b "2" -e "$2" &
fi
    
# pointer
if [ "$4" == "-p" ] ; then
	n30f -t "pointer" -x "$5" -y "34" -c "pkill -f 'n30f -t popup' && pkill -f '$2' && pkill -f 'pointer'" "$pointer"
else
	exit
fi