#!/usr/bin/env bash
# usage:
# popup [file] [placement] -p [pointer location]

# fetch the colors
source "/usr/scripts/colors.sh"

# vars
background="/usr/scripts/popup/img/bg.png"
pointer="/usr/scripts/popup/img/pointer.png"
y="70"

# exec
n30f -x "$2" \
	 -y "$(expr $y + 36)" \
	 -c "killall n30f" "$background" &
sleep ".05s"
n30f -x "$(expr $2 + 5)" \
	 -y "$(expr $y + 41)" \
	 -c "killall n30f" "$1" &

# pointer
if [ "$3" == "-p" ] ; then
	n30f -x "$(expr $2 + $4)" \
		 -y "$(expr $y + 30)" \
		 -c "killall n30f" "$pointer"
else
	exit
fi