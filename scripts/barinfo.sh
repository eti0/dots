#!/usr/bin/env bash
# requires https://github.com/stark/siji installed to display icons

# define the colors
accent="%{F#a5bcc0}"
text="%{F#e1e9ea}"

clock() {
	datetime=$(date "+%a %R")
	echo -n $accent$text $datetime
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	echo $accent$text $level
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

rsong() {
	rcsong=$(mpc -h lemon.eti.tf -p 5577 current)
	rplaying=$(mpc -h lemon.eti.tf -p 5577 status | grep -o 'playing')

	if test "$rplaying" = "playing"; then
		echo $accent$text $rcsong
	else test "$rplaying" = "";
		echo ''
	fi
}

desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
	for w in `seq 0 $((cur - 1))`; do line="${line}$accent◽ "; done
	line="${line}$text◾"
	for w in `seq $((cur + 2)) $tot`; do line="${line}$accent ◽"; done
	echo $line
}

network() {
	cnetwork=$(iwgetid -r)
	echo $accent$text $cnetwork
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if test $power = "Charging" ; then
		echo -n "$accent$text $percent%"
	else
		if test $percent -gt 80 ; then
			echo -n "$accent$text $percent%"
		elif test $percent -gt 50 ; then
			echo -n "$accent$text $percent%"
		else
			echo -n "$accent$text $percent%"
		fi
	fi
}

# print all
while true; do
	echo "%{l} $(desktops)  $(rsong) %{c}$(clock) %{r}$(sound) "
	sleep 0.5
done
