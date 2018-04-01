#!/usr/bin/env bash
# vars
colors="/usr/scripts/colors.sh"
refresh=".2"
padding="   "
height="30"
font="-*-cure-*"
ifont="-*-siji-*"
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
	current="$(mpc "current")"
	printf "$current"
}

spotify() {
	current="$(sps "current")"
	if [ "$current" == "Spotify is not running." ] ; then
		:
	else
		printf "$current"
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
	echo "$percent%%"
}

clock() {
	clock="$(date "+%R")"
	printf "$clock"
}


# loops
dloop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding$bg\
		%{A:sps 'play' &:}$padding$(spotify)$padding%{A}$bg\
		%{c}\
		%{A:calendar &:}$padding$(clock)$padding%{A}$bg\
		%{r}\
		%{A:notify-send 'updating the weather' && weather --noicon &:}$padding$(weather)$padding%{A}$bg"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-f "$ifont" \
		-g "x"$height"" \
	| bash
}

lloop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding$bg\
		%{A:sps 'play' &:}$padding$(spotify)$padding%{A}$bg\
		%{c}\
		%{A:calendar &:}$padding$(clock)$padding%{A}$bg\
		%{r}\
		%{A:batstat &:}$padding$(battery)$padding%{A}$bg"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-f "$ifont" \
		-g "x"$height"" \
	| bash
}


# exec
if [ -f "/sys/class/power_supply/"$battery"/status" ] ; then
	lloop
else
	dloop
fi