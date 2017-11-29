#!/usr/bin/env bash

# fetch the colors
source "/usr/scripts/colors.sh"

# vars
p="   "
barh="30"
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
pos=$(expr "$height" - "$barh")


desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}- "; done
	line="${line}÷"
	for w in `seq $((cur + 2)) $tot`; do line="${line} -"; done
	echo $line
}

workspace() {
	cur=$(xdotool "get_desktop")

	if [ "$cur" == "0" ] ; then
		printf "un"
	elif [ "$cur" == "1" ] ; then
		printf "deux"
	elif [ "$cur" == "2" ] ; then
		printf "trois"
	elif [ "$cur" == "3" ] ; then
		printf "quatre"
	elif [ "$cur" == "4" ] ; then
		printf "cinq"
	else
		printf "???"
	fi
}

song() {
	csong=$(mpc current)
	playing=$(mpc status | grep -o 'playing' )

	if [ "$playing" == "playing" ]; then
		echo "$p$af0$txt $csong$p"
	else
		:
	fi
}

window() {
	cwindow=$(xdotool "getwindowfocus" "getwindowname")

	if [ "$cwindow" == "Openbox" ] ; then
		:
	else
		echo "$p$af0$txt $cwindow$p"
	fi
}

weather() {
	cat "/tmp/weather"
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
	datetime=$(date "+$af0$txt %A %R")
	echo $datetime
}

loop-desktop() {
	while :; do
		echo "%{l}\
		$a1$af2%{A1:urxvt -name popup -e ncmpcpp &:}%{A3:mpc toggle &:}$p$(workspace)$p%{A}%{A}$txt$bg\
		$a2%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}$bg\
		$a2$(window)$bg\
		%{r}\
		$a2%{A:/usr/scripts/weather.sh:}$p$(weather)$p%{A}$bg\
		$a2%{A:/usr/scripts/vol.sh -t &:}$p$(sound)$p%{A}$bg\
		$a2%{A:/usr/scripts/popup/calendar.sh &:}$p$(clock)$p%{A}$bg"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x$barh++$pos" \
	    | bash
}

loop-laptop() {
	while :; do
		echo "%{l}\
		$a1$af2%{A1:urxvt -name popup -e ncmpcpp &:}%{A3:mpc toggle &:}$p$(workspace)$p%{A}%{A}$txt$bg\
		$a2%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}$bg\
		$a2$(window)$bg\
		%{r}\
		$a2%{A:notify-send 'updating the weather status' && /usr/scripts/weather.sh:}$p$(weather)$p%{A}$bg\
		$a2%{A:/usr/scripts/batstat.sh:}$p$(battery)$p%{A}$bg\
		$a2%{A:/usr/scripts/popup/calendar.sh &:}$p$(clock)$p%{A}$bg"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x$barh++$pos" \
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