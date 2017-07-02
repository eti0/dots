#!/usr/bin/env bash
# requires https://github.com/stark/siji installed to display icons

# define the colors
accent="%{F#B6B6B6}"
text="%{F#eee}"

clock() {
	datetime=$(date +%R)
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

desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
	for w in `seq 0 $((cur - 1))`; do line="${line} ◽"; done
	line="${line} $text◾$accent"
	for w in `seq $((cur + 2)) $tot`; do line="${line} ◽"; done
	echo $line
}

network() {
	cnetwork=$(iwgetid -r)
	echo $accent$text $cnetwork
}

battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power_now=$(cat /sys/class/power_supply/BAT0/power_now)

    fullthing="${symbol}$text ${percent}%"

    if test $power_now = "0"; then
        symbol=""
        echo -n "${symbol}$text ${percent}%"
    elif test $percent = "98"; then
        symbol=""
        echo -n "${symbol}$text 100%"
    else
        if test $percent -gt 60; then
            symbol=""
            echo -n "${symbol}$text ${percent}%"
        elif test $percent -gt 30; then
            symbol=""
            echo -n "${symbol}$text ${percent}%"
        else
            symbol=""
            echo -n "${symbol}$text ${percent}%"
        fi
    fi
}

# print all
while true; do
	echo "$accent%{l} $(desktops) %{c}$(clock) %{r}$(network)  $(sound)  $accent$(battery) "
	sleep 0.2
done
