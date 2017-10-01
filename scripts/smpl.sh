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
	csong=$(mpc current | head -c50)
	playing=$(mpc status | grep -o 'playing' )

	if [ "$playing" == "playing" ]; then
		echo "$af0$txt"
	else [ "$playing" == "" ];
		echo ""
	fi
}

clock() {
	datetime=$(date "+%a %R")
	echo $datetime
}

network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo $wrn$txt
	else
		echo $af0$txt
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

loop-desktop() {
	while :; do
			echo "%{l}%{A1:popup.sh "term" "ncmpcpp" "60x20+753+60" &:}%{A3:mpc toggle &:}$p$(desktops)$p%{A}%{A}%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}$bg\
			%{c}$p%{A:/usr/scripts/popup/calendar.sh d &:}$(clock)%{A}$p\
			%{r}$p$(sound)$p$bg"
			sleep ".2s"
		done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "512x30+704+20" \
	    | bash
}

loop-laptop() {
	while :; do
			echo "%{l}%{A1:popup.sh "term" "ncmpcpp" "60x20+476+60" &:}%{A3:mpc toggle &:}$p$(desktops)$p%{A}%{A}%{A:/usr/scripts/popup/cover.sh l &:}$(song)%{A}$bg\
			%{c}%{A:/usr/scripts/popup/calendar.sh l &:}$p$(clock)$p%{A}\
			%{r}%{A:gnome-control-center network &:}$p$(network)$p%{A}$(sound)$p$(battery)$p$bg"
			sleep ".2s"
		done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "512x30+427+20" \
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