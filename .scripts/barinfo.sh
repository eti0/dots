#!/bin/bash

clock() {
	DATETIME=$(date +%R)
	echo -n %{F#B6B6B6}%{F#eee} $DATETIME
}

sound() {
	SOUND=$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)
	echo %{F#B6B6B6}%{F#eee} $SOUND%
}

song() {
	CURRENTSONG=$(mpc -p 7755 current)
	PLAYING=$(mpc -p 7755 status | grep -o 'playing')

	if test "$PLAYING" = "playing"; then
		echo %{F#B6B6B6}%{F#eee} $CURRENTSONG
	else test "$PLAYING" = "";
		echo ''
	fi
}

desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
	for w in `seq 0 $((cur - 1))`; do line="${line} ◽"; done
	line="${line} %{F#eee}◾%{F#B6B6B6}"
	for w in `seq $((cur + 2)) $tot`; do line="${line} ◽"; done
	echo $line
}

network() {
	CNETWORK=$(iwgetid -r)
	echo %{F#B6B6B6}%{F#eee} $CNETWORK
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power_now=$(cat /sys/class/power_supply/BAT0/power_now)

    fullthing="${symbol}%{F#eee} ${percent}%"

    if test $power_now = "0"; then
        symbol=""
        echo -n "${symbol}%{F#eee} ${percent}%"
    elif test $percent = "98"; then
        symbol=""
        echo -n "${symbol}%{F#eee} 100%"
    else
        if test $percent -gt 60; then
            symbol=""
            echo -n "${symbol}%{F#eee} ${percent}%"
        elif test $percent -gt 30; then
            symbol=""
            echo -n "${symbol}%{F#eee} ${percent}%"
        else
            symbol=""
            echo -n "${symbol}%{F#eee} ${percent}%"
        fi
    fi
}

# print all
while true; do
	echo "%{F#B6B6B6}%{l} $(desktops)%{c}$(clock)%{r}$(network)  $(sound)  %{F#B6B6B6}$(battery) "
	sleep 0.25
done
