#!/usr/bin/env bash
# vars
colors="/usr/scripts/colors.sh"
refresh=".1"
padding="    "
height="35"
font="-*-euphon-*"
font2="-*-ijis-*"
font3="-*-vanilla-*"
font4="-efont-biwidth-*"
battery="BAT0"


# colors
source "$colors"


# functions
desktop() {
	cur=$(xdotool get_desktop)
	first="%{A:xdotool set_desktop 0 &:}one%{A}"
	second="%{A:xdotool set_desktop 1 &:}two%{A}"
	third="%{A:xdotool set_desktop 2 &:}three%{A}"
	fourth="%{A:xdotool set_desktop 3 &:}four%{A}"
	fifth="%{A:xdotool set_desktop 4 &:}five%{A}"
	case "$cur" in
		0)
		echo "${a2}${a0}%{+u}${af4}${padding}${first}${padding}${txt}%{-u}${a2}${padding}${second}${padding}${padding}${third}${padding}${padding}${fourth}${padding}${padding}${fifth}${padding}"
		;;
		1)
		echo "${a2}${padding}${first}${padding}${a0}%{+u}${af4}${padding}${second}${padding}${txt}%{-u}${a2}${padding}${third}${padding}${padding}${fourth}${padding}${padding}${fifth}${padding}"
		;;
		2)
		echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${a0}%{+u}${af4}${padding}${third}${padding}${txt}%{-u}${a2}${padding}${fourth}${padding}${padding}${fifth}${padding}"
		;;
		3)
		echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${padding}${third}${padding}${a0}%{+u}${af4}${padding}${fourth}${padding}${txt}%{-u}${a2}${padding}${fifth}${padding}"
		;;
		4)
		echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${padding}${third}${padding}${padding}${fourth}${padding}${a0}%{+u}${af4}${padding}${fifth}${padding}${txt}%{-u}${a2}"
	esac
}

window() {
	cur="$(xdotool getwindowname $(xdotool getactivewindow) | head -c 150 | sed 's/ \- / \: /')"
	if [[ "$cur" ]] ; then
		echo "$padding$padding$cur$padding$padding"
	else
		:
	fi
}

clock() {
	# date "+$padding%R$padding"
	# tempus
	born="$(date -d '5 Nov 1998' +%s)"
	now="$(date -d now +%s)"
	# printf "$(((now - born) / 86400)) days spent on earth"
    tempus
}

irc() {
	pgrep -f "urxvt -name irc" > "/dev/null" 2>&1
	if [ "$?" -ne "1" ] ; then
		echo "$a1$padding :: $padding$bg"
	else
		:
	fi
}

mpris() {
	ignore="chrome"
	playerctl metadata --ignore-player="$ignore" --format "${padding}np: {{ artist }} : {{ title }}${padding}" 2> "/dev/null" | sed "s/Player not found//"
}


# loop
loop() {
	while :; do
		echo "%{l}\
		%{A4:xdotool set_desktop $(expr $(xdotool get_desktop) - 1) &:}%{A5:xdotool set_desktop $(expr $(xdotool get_desktop) + 1) &:}$(desktop)%{A}%{A}$bg\
		%{A:playerctl play-pause &:}$(mpris)%{A}\
		%{r}\
		$a2%{A:notify-send $(date "+%H\:%M\ %d/%m") &:}$padding$(clock)$padding%{A}$bg\
		%{A:toggle-tch &:}$(irc)%{A}$bg"
		sleep "$refresh"
	done |\

	lemonbar \
	-f "$font" \
	-f "$font2" \
	-f "$font3" \
	-f "$font4" \
	-g "x$height" \
	-F "$text" \
	-B "$background" \
	-U "$acc3" \
	-u "0" \
	-a "20" \
	| bash
}

# exec
loop