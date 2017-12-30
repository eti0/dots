#!/usr/bin/env bash


# fetch the colors
source "/usr/scripts/colors.sh"


# vars
p="  "
barh="30"
barw="140"
margin="30"


# functions
song() {
	playing="$(mpc status | grep -o 'playing' )"

	if [ "$playing" == "playing" ]; then
		echo "$p$p"
	else
		:
	fi
}

clock() {
	datetime="$(date "+%a %R")"
	echo "$datetime"
}

battery() {
    percent="$(cat /sys/class/power_supply/BAT0/capacity)"
    power="$(cat /sys/class/power_supply/BAT0/status)"
	
	if [[ $power == "Charging" || $power == "Unknown" ]]; then
		echo -n "$percent%"
	else
		if [ $percent -eq 100 ]; then
			echo -n "$percent%"
		elif [ $percent -gt 70 ] ; then
			echo -n "$percent%"
		elif [ $percent -gt 30 ]; then
			echo -n "$percent%"
		else 
			echo -n "$percent%"
		fi
	fi
}


# loops
loop-desktop() {
	while :; do
		echo "%{l}\
		$bg$txt%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}\
		$a1$bgf%{A1:urxvt -name popup -e ncmpcpp &:}%{A3:mpc toggle &:}$p$(clock)$p%{A}%{A}\
		%{B#00000000}"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g ""$barw"x"$barh"+"$margin"+"$margin"" \
	    -d \
	    | bash
}

loop-laptop() {
	while :; do
		echo "%{l}\
		$bg$txt%{A:/usr/scripts/popup/cover.sh d &:}$(song)%{A}\
		$a1$bgf%{A1:urxvt -name popup -e ncmpcpp &:}%{A3:mpc toggle &:}$p$(clock)$p%{A}%{A}\
		-\
		%{A:/usr/scripts/batstat.sh:}$p$(battery)$p%{A}\
		%{B#00000000}"
		sleep ".2s"
	done |\
	
	lemonbar \
	    -f '-x-vanilla-*' \
	    -f '-wuncon-siji-*' \
	    -g ""$barw"x"$barh"+"$margin"+"$margin"" \
	    -d \
	    | bash
}


# exec
if [ -f "/sys/class/power_supply/BAT0/status" ] ; then
	loop-laptop
else
	loop-desktop
fi