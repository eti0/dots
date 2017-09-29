#!/usr/bin/env bash

# source the colors from colors.sh
source "/usr/scripts/colors.sh"

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

song() {
	csong=$(mpc current | head -c50)
	playing=$(mpc status | grep -o 'playing' )

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

weather() {
	cat "/tmp/fweather"
}

network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo $wrn$txt
	else
		echo  $cnetwork
	fi
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	muted=$(amixer get Master | grep -o off | tail -n1)
	
	if [ "$muted" == "off" ]; then
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
		elif [ $percent -gt 30 ]; then
			echo -n " $percent%"
		else 
			echo -n " $percent%"
		fi
	fi
}

loop-desktop() {
	while :; do
		echo "%{l}%{A1:popup.sh "term" "ncmpcpp" "60x20+760+40" &:}%{A3:mpc toggle &:}$a0$p$(desktops)$p%{A}%{A}%{A:cover.sh &:}$a1$(song)%{A}$(window)$bg\
		%{c}$p%{A:calendar.sh &:}$(clock)%{A}$p\
		%{r}$a2$p$(weather)$p$a0$p$(sound)$p$bg"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x30" \
	    | bash
}

loop-laptop() {
	while :; do
		echo "%{A1:popup.sh "term" "ncmpcpp" "60x20+476+40" &:}%{A3:mpc toggle &:}$a0%{l}$p$(desktops)$p%{A}%{A}%{A:cover.sh &:}$a1$(song)%{A}$(window)$bg\
		%{c}$p%{A:calendar.sh:}$(clock)%{A}$p\
		%{r}%{A:pkill -f '/usr/scripts/fweather.sh' & /usr/scripts/fweather.sh:}$a3$p$(weather)$p$a3%{A}$a2$p$(network)$p$a1$p$(sound)$p$a0$p$(battery)$p$bg"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g "x30" \
	    | bash
}

if [ "$1" == "d" ] ; then
	loop-desktop "$@"
elif [ "$1" == "l" ] ; then
	loop-laptop "$@"
else
	printf "usage: bar [arg]"
fi