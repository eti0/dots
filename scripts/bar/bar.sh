#!/usr/bin/env bash

# source the colors from colors.sh
source "/usr/scripts/bar/colors.sh"

# vars
p="  "

desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}◽ "; done
	line="${line}◾"
	for w in `seq $((cur + 2)) $tot`; do line="${line} ◽"; done
	echo $line
}

song() {
	csong=$(mpc current)
	playing=$(mpc status | grep -o 'playing')

	if [ "$playing" == "playing" ]; then
		echo "   $csong  "
	else [ "$playing" == "" ];
		echo ""
	fi
}

clock() {
	datetime=$(date "+%a %R")
	echo $datetime
}

window() {
	cwindow=$(xdotool "getwindowfocus" "getwindowname" | head -c50)

	if [ "$cwindow" == "Openbox" ] ; then
		echo ""
	elif [ "$(song)" == "" ] ; then
		echo "$a1   $cwindow  "
	else
		echo "$a2   $cwindow  "
	fi
}

network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo $wrn$txt offline
	else
		echo  $cnetwork
	fi
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	if [ "$level" == "0%" ]; then
		echo $wrn$txt
	else
		echo  $level
	fi
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if [[ $power == "Charging" || $power == "Unknown" ]]; then
		echo -n " $percent%"
	else
		if [ $percent -eq 100 ]; then
			echo -n " $percent%"
		elif [ $percent -gt 80 ] ; then
			echo -n " $percent%"
		elif [ $percent -gt 50 ]; then
			echo -n " $percent%"
		else 
			echo -n " $percent%"
		fi
	fi
}

while true ; do
	echo "%{A1:mpc toggle:}$a0%{l}$p$(desktops)$p%{A}%{A3:cover.sh:}%{A:popup.sh "term" "ncmpcpp" "80x20+481+40":}$a1$(song)%{A}%{A}$(window)$bg\
	%{c}$p%{A:calendar.sh:}$(clock)%{A}$p\
	%{r}%{A:popup.sh "term" "nmtui" "60x25+994+40":}$a2$p$(network)$p%{A}%{A:popup.sh "term" "alsamixer" "60x25+994+40":}$a1$p$(sound)$p%{A}$a0$p$(battery)$p$bg"
	sleep ".2s"
done