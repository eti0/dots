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
	if [ "$level" == "0%" ]; then
		echo $accent$text muted
	else
		echo $accent$text $level
	fi
}


song() {
	csong=$(mpc current)
	playing=$(mpc status | grep -o 'playing')

	if [ "$playing" = "playing" ]; then
		echo $accent$text $csong
	else [ "$playing" = "" ];
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

	if [ "$cnetwork" == "" ]; then
		echo $accent$text offline
	else
		echo $accent$text $cnetwork
	fi
}


battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if [ $power == "Charging" ] ; then
		echo -n "$accent$text $percent%"
	else
		if [ $percent == 100 ]; then
			echo -n "$accent$text $percent%"
		elif [ $percent > 80 ] ; then
			echo -n "$accent$text $percent%"
		elif [ $percent > 50 ]; then
			echo -n "$accent$text $percent%"
		else 
			echo -n "$accent$text $percent%"
		fi
	fi
}


while true ; do
	echo "%{l}$padding$(desktops)$padding$(song)$padding%{A:urxvtc -e 'ncmpcpp':}%{A3:mpc toggle:}$bgc%{A}%{A} \
	      %{c}%{A:ndate.sh:}$(clock)%{A} \
	      %{r}%{A:urxvtc -e 'nmtui':}$(network)%{A}$padding%{A:urxvtc -e 'alsamixer':}$(sound)%{A}$padding$(battery)$padding"
	sleep ".3s"
done
