#!/usr/bin/env bash
# vars
colors="/usr/scripts/colors.sh"
refresh=".2"
padding="   "
height="40"
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
	echo "$percent%"
}

clock() {
	clock="$(date "+%R")"
	printf "$clock"
}


# loops
dloop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding\
		%{A:sps 'play' & mpc 'toggle' &:}%{A2:cover &:}%{A3:urxvt -e 'ncmpcpp' &:}$padding$(mpd)$(spotify)$padding%{A}%{A}%{A}\
		%{c}\
		%{A:calendar &:}$padding$(clock)$padding%{A}\
		%{r}\
		%{A:notify-send 'updating the weather' && weather --noicon &:}$padding$(weather)$padding%{A}"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-f "$ifont" \
		-g "x"$height"" \
		-B "$background" \
	| bash
}

lloop() {
	while :; do
		echo "%{l}\
		$padding$(desktop)$padding\
		%{A:sps 'play' & mpc 'toggle' &:}%{A2:cover &:}%{A3:urxvt -e 'ncmpcpp' &:}$padding$(mpd)$(spotify)$padding%{A}%{A}%{A}\
		%{c}\
		%{A:calendar &:}$padding$(clock)$padding%{A}\
		%{r}\
		%{A:batstat &:}$padding$(battery)$padding%{A}"
		sleep "$refresh"
	done |\

	lemonbar \
		-f "$font" \
		-f "$ifont" \
		-g "x"$height"" \
		-B "$background" \
	| bash
}


# exec
if [ -f "/sys/class/power_supply/"$battery"/status" ] ; then
	lloop
else
	dloop
fi