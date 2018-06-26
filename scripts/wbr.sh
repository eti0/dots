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
	current="$(xdotool 'get_desktop')"
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
	artist="$(mpc -f '%artist%' | head -1)"
	song="$(mpc -f '%title%' | head -1)"
	if [ "$(mpc current)" ] ; then
		echo "$a2$padding$artist : $song$padding$bg"
	else
		:
	fi
}

spotify() {
	current="$(sps 'current' | sed 's/ \- / \: /')"
	if [ "$current" == "Spotify is not running." ] ; then
		:
	else
		echo "$a2$padding$current$padding$bg"
	fi
}

window() {
	current="$(xdotool 'getwindowfocus' 'getwindowname')"
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
	percent="$(cat '/sys/class/power_supply/$battery/capacity')"
	echo "$percent%"
}

clock() {
	time="$(date '+%j')"
	printf "$time days around the sun"
}


# loops
desktop_loop() {
	while :; do
		echo "%{l}\
		%{A2:cover &:}%{A:mpc 'toggle' &:}%{A3:urxvt -e 'ncmpcpp' &:}$(mpd)%{A}%{A}%{A:sps 'play' &:}$(spotify)$padding%{A}%{A}\
		%{r}\
		$a2%{A:calendar &:}$padding$(clock)$padding%{A}$bg"
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
		$a3$padding$(desktop)$padding$bg\
		%{A2:cover &:}%{A:mpc 'toggle' &:}%{A3:urxvt -e 'ncmpcpp' &:}$(mpd)%{A}%{A}%{A:sps 'play' &:}$(spotify)$padding%{A}%{A}\
		%{r}\
		%{A:batstat &:}$padding$(battery)$padding%{A}\
		$a2%{A:calendar &:}$padding$(clock)$padding%{A}$bg"
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
