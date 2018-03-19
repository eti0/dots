#!/usr/bin/env bash


# fetch the colors
source "/usr/scripts/colors.sh"


# vars
rrate=".2s"
p="   "
barh="30"
margin="30"
font="-*-cure-*"
iconfont="-*-siji-*"


# functions
desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}- "; done
	line="${line}÷"
	for w in `seq $((cur + 2)) $tot`; do line="${line} -"; done
	echo "$line"
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
		echo "$p$csong$p"
	else
		:
	fi
}

spotify() {
	current=$(spotifycli --status)

	if [ "$current" == "spotify is off" ]; then
		:
	else
		printf "$p$current$p"
	fi
}

window() {
	cwindow=$(xdotool "getwindowfocus" "getwindowname")

	if [ "$cwindow" == "Openbox" ] ; then
		:
	else
		echo "$p$cwindow$p"
	fi
}

crypto() {
	ccv="$(cat "/tmp/crypto")"
	echo "$ccv"
}

weather() {
	cat "/tmp/weather"
}

network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo "$wrn$txt"
	else
		echo "$cnetwork"
	fi
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	muted=$(amixer get Master | grep -o off | tail -n1)
	
	if [ "$muted" == "off" ]; then
		echo "$wrn$txt"
	else
		echo "$level"
	fi
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
    
	if [[ $power == "Charging" || $power == "Unknown" ]]; then
		echo -n "$percent%"
	else
		if [ $percent -eq 100 ]; then
			echo -n "$percent%"
		elif [ $percent -gt 80 ] ; then
			echo -n "$percent%"
		elif [ $percent -gt 30 ]; then
			echo -n "$percent%"
		else 
			echo -n "$percent%"
		fi
	fi
}

clock() {
	datetime=$(date "+%a %R")
	echo "$datetime"
}

loop-desktop() {
	while :; do
		echo "%{l}\
		$a1$af2%{A3:spotifycli --playpause &:}$p$(workspace)$p%{A}$txt$bg\
		$a3$(spotify)$bg\
		$a2$(window)$bg\
		%{r}\
		$a2%{A:notify-send 'updating the weather...' && weather &:}$p$(weather)$p%{A}$bg\
		$a2%{A:calendar &:}$p$(clock)$p%{A}$bg"
		sleep "$rrate"
	done |\
	
	lemonbar \
	    -f "$font" \
   	    -f "$iconfont" \
	    -g "x"$barh"" \
	    -b \
	    | bash
}

loop-laptop() {
	while :; do
		echo "%{l}\
		$a1$af2%{A3:spotifycli --playpause &:}$p$(workspace)$p%{A}$txt$bg\
		$a3$(spotify)$bg\
		$a2$(window)$bg\
		%{r}\
		$a2%{A:batstat &:}$p$(battery)$p%{A}$bg\
		$a2%{A:calendar &:}$p$(clock)$p%{A}$bg"
		sleep "$rrate"
	done |\
	
	lemonbar \
	    -f "$font" \
	    -f "$iconfont" \
	    -g "x"$barh"" \
	    -b \
	    | bash
}


# exec
if [ -f "/sys/class/power_supply/BAT0/status" ] ; then
	loop-laptop
else
	loop-desktop
fi