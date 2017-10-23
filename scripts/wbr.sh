#!/usr/bin/env bash

# source the colors from colors.sh
source "/usr/scripts/colors.sh"

# vars
p="   "

desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}- "; done
	line="${line}$af0-$txt"
	for w in `seq $((cur + 2)) $tot`; do line="${line} -"; done
	echo $line
}

song() {
	csong=$(mpc current)
	playing=$(mpc status | grep -o 'playing' )

	if [ "$playing" == "playing" ]; then
		echo "$af0$txt $csong$p"
	else [ "$playing" == "" ];
		echo ""
	fi
}

window() {
	cwindow=$(xdotool "getwindowfocus" "getwindowname")

	if [ "$cwindow" == "Openbox" ] ; then
		echo ""
	else
		echo "$af0$txt $cwindow  "
	fi
}

weather() {
	cat "/tmp/fweather"
}

network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo $wrn$txt
	else
		echo $af0$txt $cnetwork
	fi
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	muted=$(amixer get Master | grep -o off | tail -n1)
	
	if [ "$muted" == "off" ]; then
		echo $wrn$txt
	else
		echo $af0$txt $level
	fi
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if [[ $power == "Charging" || $power == "Unknown" ]]; then
		echo -n "$af0$txt $percent%"
	else
		if [ $percent -eq 100 ]; then
			echo -n "$af0$txt $percent%"
		elif [ $percent -gt 80 ] ; then
			echo -n "$af0$txt $percent%"
		elif [ $percent -gt 30 ]; then
			echo -n "$af0$txt $percent%"
		else 
			echo -n "$af0$txt $percent%"
		fi
	fi
}

clock() {
	datetime=$(date "+$af0$txt %a %R")
	echo $datetime
}

loop-desktop() {
	while :; do
			echo "%{l}%{A1:popup.sh "term" "ncmpcpp" "60x20+753+30" &:}%{A3:mpc toggle &:}$p$(desktops)$p%{A}%{A}%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}$(window)\
			%{r}$(weather)%{A:/usr/scripts/vol.sh -t &:}$p$(sound)$p%{A}%{A:/usr/scripts/popup/calendar.sh d &:}$(clock)%{A}$p$bg"
			sleep ".2s"
		done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x30++1050" \
	    | bash
}

loop-laptop() {
	while :; do
			echo "%{l}%{A1:popup.sh "term" "ncmpcpp" "60x20+476+30" &:}%{A3:mpc toggle &:}$p$(desktops)$p%{A}%{A}%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}$(window)\
			%{r}%{A:/usr/scripts/vol.sh -t &:}%{A:gnome-control-center wifi &:}$(network)$p%{A}%{A:/usr/scripts/vol.sh -t &:}$(sound)$p%{A}$(battery)  %{A:/usr/scripts/popup/calendar.sh d &:}$(clock)%{A}$p$bg"
			sleep ".2s"
		done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x30++738" \
	    | bash
}

if [ "$1" == "d" ] ; then
	loop-desktop "$@"
elif [ "$1" == "l" ] ; then
	loop-laptop "$@"
else
	printf "no arguments given\nusage: bar [ d (desktop) | l (laptop) ]\n"
	exit 1
fi