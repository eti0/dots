#!/usr/bin/env bash
# vars
colors="/usr/scripts/colors.sh"
refresh=".2"
padding="    "
height="40"
font="-*-euphon-*"
battery="BAT0"


# colors
source "$colors"


# functions
desktop() {
	current="$(xdotool "get_desktop")"
	case "$current" in
		"0")
			desktop="un"
			;;
		"1")
			desktop="deux"
			;;
		"2")
			desktop="trois"
			;;
		"3")
			desktop="quatre"
			;;
		"4")
			desktop="cinq"
			;;
		*)
			desktop="???"
			;;
	esac
	printf "$desktop"
}

mpd() {
	current="$(mpc "current" | sed "s/ \- / \: /")"
	if [ "$current" ] ; then
		printf "%.0s-$padding$current$padding"
	else
		:
	fi
}

spotify() {
	current="$(sps "current" | sed "s/ \- / \: /")"
	if [ "$current" == "Spotify is not running." ] ; then
		:
	else
		printf "%.0s-$padding$current$padding"
	fi
}

window() {
	current="$(xdotool "getwindowfocus" "getwindowname")"
	if [ "$current" = "Openbox" ] ; then
		:
	else
		printf "$current"
	fi
}

weather() {
	cat "/tmp/weather"
}

battery() {
	percent="$(cat "/sys/class/power_supply/"$battery"/capacity")"
	echo "$percent%"
}

clock() {
	tempus
}


# loops
desktop_loop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding\
		%{A:mpc 'toggle' &:}%{A2:notify-send 'looking for a cover' && cover &:}%{A3:urxvt -e 'ncmpcpp' &:}$(mpd)%{A}%{A}%{A:sps 'play' &:}$(spotify)$padding%{A}%{A}\
		%{r}\
		%{A:notify-send 'updating the weather' && weather --noicon &:}$padding$(weather)$padding%{A}\
		-\
		%{A:calendar &:}$padding$(clock)$padding%{A}"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-g "x"$height"" \
		-F "$text" \
		-B "$background" \
	| bash
}

laptop_loop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding\
		%{A:mpc 'toggle' &:}%{A2:notify-send 'looking for a cover' && cover &:}%{A3:urxvt -e 'ncmpcpp' &:}$(mpd)%{A}%{A}%{A:sps 'play' &:}$(spotify)$padding%{A}%{A}\
		%{r}\
		%{A:batstat &:}$padding$(battery)$padding%{A}\
		-\
		%{A:calendar &:}$padding$(clock)$padding%{A}"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-g "x"$height"" \
		-F "$text" \
		-B "$background" \
	| bash
}


# exec
if [ -f "/sys/class/power_supply/$battery/status" ] ; then
	laptop_loop
else
	desktop_loop
fi
