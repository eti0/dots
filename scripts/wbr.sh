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
	first="%{A:xdotool set_desktop 0 &:}ראשון%{A}"
	second="%{A:xdotool set_desktop 1 &:}השני%{A}"
	third="%{A:xdotool set_desktop 2 &:}שלישית%{A}"
	fourth="%{A:xdotool set_desktop 3 &:}רביעי%{A}"
	fifth="%{A:xdotool set_desktop 4 &:}חמישי%{A}"
	case "$cur" in
		0)
			echo "${a2}${a0}%{+u}${padding}${first}${padding}%{-u}${a2}${padding}${second}${padding}${padding}${third}${padding}${padding}${fourth}${padding}${padding}${fifth}${padding}"
			;;
		1)
			echo "${a2}${padding}${first}${padding}${a0}%{+u}${padding}${second}${padding}%{-u}${a2}${padding}${third}${padding}${padding}${fourth}${padding}${padding}${fifth}${padding}"
			;;
		2)
			echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${a0}%{+u}${padding}${third}${padding}%{-u}${a2}${padding}${fourth}${padding}${padding}${fifth}${padding}"
			;;
		3)
			echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${padding}${third}${padding}${a0}%{+u}${padding}${fourth}${padding}%{-u}${a2}${padding}${fifth}${padding}"
			;;
		4)
			echo "${a2}${padding}${first}${padding}${padding}${second}${padding}${padding}${third}${padding}${padding}${fourth}${padding}${a0}%{+u}${padding}${fifth}${padding}%{-u}${a2}"
	esac
}

window() {
	cur="$(xdotool getwindowname $(xdotool getactivewindow) | head -c 150)"
	if [[ "$cur" ]] ; then
		echo "$padding$padding$cur$padding$padding"
	else
		:
	fi
}

mpd() {
	artist="$(mpc -f '%artist%' | head -1 | sed 's/\;/ + /')"
	song="$(mpc -f '%title%' | head -1 | sed 's/(feat\./( +/')"
	progress="$(mpc | sed 's/.*(//;s/)//;2q;d')"
	if [ "$(mpc current)" ] ; then
		echo "$a2$padding$artist : $song : $progress$padding$bg"
	else
		:
	fi
}

spotify() {
	current="$(sps 'current' | sed 's/ \- / \: /')"
	if [ "$current" == "No media player is currently running" ] ; then
		:
	else
		echo "$a2$padding$current$padding$bg"
	fi
}

weather() {
	file="/tmp/weather"
	cat "$file"
}

clock() {
	date "+$padding%R$padding"
}

irc() {
	pgrep -f "urxvt -name irc" > /dev/null 2>&1
	if [ "$?" -ne "1" ] ; then
		echo "$a1$padding :: $padding$bg"
	else
		:
	fi
}


# loop
loop() {
	while :; do
		echo "%{l}\
		$a1$(window)$bg\
		%{A4:xdotool set_desktop $(expr $(xdotool get_desktop) - 1) &:}%{A5:xdotool set_desktop $(expr $(xdotool get_desktop) + 1) &:}$(desktop)%{A}%{A}$bg\
		%{A2:cover &:}%{A:mpc 'toggle' &:}%{A3:urxvt -e 'ncmpcpp' &:}$(mpd)%{A}%{A}%{A:sps 'play' &:}$(spotify)$padding%{A}%{A}$bg\
		%{r}\
		$a2%{A:calendar &:}$padding$(clock)$padding%{A}$bg\
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