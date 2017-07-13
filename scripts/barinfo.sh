#!/usr/bin/env bash
# requires https://github.com/stark/siji installed to display icons


# fetch the colors from colors.sh
user=$(whoami)
source "/home/$user/.scripts/colors.sh"


# define the padding size
padding="  "


clock() {
	datetime=$(date "+%a %R")
	echo -n $accent$text $datetime
}


sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	echo $accent$text $level
}


song() {
	csong=$(mpc -p 7755 current)
	playing=$(mpc -p 7755 status | grep -o 'playing')

	if test "$playing" = "playing"; then
		echo $accent$text $csong
	else test "$playing" = "";
		echo ''
	fi
}


desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}$text◽ "; done
	line="${line}$accent◾"
	for w in `seq $((cur + 2)) $tot`; do line="${line}$text ◽"; done
	echo $line
}


network() {
	cnetwork=$(iwgetid -r)

	if test "$cnetwork" = "" ; then
		echo $accent$text offline
	else
		echo $accent$text $cnetwork
	fi
}


battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if test $power = "Charging" ; then
		echo -n "$accent$text $percent%"
	else
		if test $percent -eq 100 ; then
			echo -n "$accent$text $percent%"
		elif test $percent -gt 80 ; then
			echo -n "$accent$text $percent%"
		elif test $percent -gt 50 ; then
			echo -n "$accent$text $percent%"
		else 
			echo -n "$accent$text $percent%"
		fi
	fi
}


brightness() {
	level=$(xbacklight)
	smp=$(printf '%.0f\n' $level)

	echo $accent$text $smp%
}


while true ; do
	echo "%{l}$padding$(desktops)$padding$(song) \
	      %{c}$(clock) \
	      %{r}$(network)$padding$(sound)$padding$(battery)$padding"
	sleep ".2s"
done
