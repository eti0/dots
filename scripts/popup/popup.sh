#!/usr/bin/env bash
# usage:
# popup.sh [type] [program / file] [geometry / placement] -p [pointer location]
# e.g.: popup.sh "term" "nmtui" "60x25+1056+42"
#       popup.sh "img" "rice.png" "10" -p "24"

# vars
pointer="/usr/scripts/popup/img/pointer.png"
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
ypos=$(expr "$height" - "242")

# launch
if [ "$1" == "img" ] ; then
	n30f -t "popup" -x "$3" -y "$ypos" -c "killall n30f" "$2" &
else [ "$1" == "term" ]
	urxvt -name "popup" -g "$3" -bd "#051519" -b "20" -e "$2" &
fi
    
# pointer
if [ "$4" == "-p" ] ; then
	n30f -t "pointer" -x "$5" -y "$(expr "$ypos" + "204")" -c "killall n30f" "$pointer"
	echo $height
else
	exit
fi