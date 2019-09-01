#!/usr/bin/env bash
# vars
colors="$HOME/owncloud/Random/scripts/misc/colors.sh"
pctlTmp="/tmp/pctlTmp"
refresh=".1"
padding="       "
height="70"
underline="0"
font="Inter UI:style=bold:size=10"
font2="Noto Sans:size=12"
font3="Noto Sans CJK JP:size=12"
font4="Font Awesome 5 Free:size=12"
font5="Unifont Sample:size=16"

# colors
source "$colors"


# functions
widgetDesktop() {
	current="$(xdotool 'get_desktop')"
	icon=""
	first="один"
	second="два"
	third="три"
	fourth="четыре"
	fifth="пять"
	case "$current" in
		0)
		echo "$padding$icon$padding$first$padding"
		;;
		1)
		echo "$padding$icon$padding$second$padding"
		;;
		2)
		echo "$padding$icon$padding$third$padding"
		;;
		3)
		echo "$padding$icon$padding$fourth$padding"
		;;
		4)
		echo "$padding$icon$padding$fifth$padding"
	esac
}

widgetWindow() {
	current="$(xdotool 'getwindowname' $(xdotool 'getactivewindow' 2> '/dev/null') 2> '/dev/null' | sed 's/ - / : /g')"
	maxChars="65"
	if [[ "${#current}" > "$maxChars" ]] ; then
		current=${current::$maxChars}
		echo "$padding$padding$current...$padding$padding"
	elif [[ "$current" ]] ; then
		echo "$padding$padding$current$padding$padding"
	else
		:
	fi
}

widgetClock() {
	date "+$padding%R$padding"
}

widgetMpd() {
	artist="$(mpc -f '%artist%' | sed -n '1p;s/\;/ + /')"
	track="$(mpc -f '%title%' | sed -n '1p;s/(feat\./( +/')"
	progress="$(mpc | sed 's/.*(//;s/)//;2q;d')"
	if [ "$(mpc current)" ] ; then
		if [ "$(mpc | grep 'paused')" ] ; then
			echo "$padding▶$padding$artist : $track + $progress$padding"
		else
			echo "$padding⏸$padding$artist : $track + $progress$padding"
		fi
	else
		:
	fi
}

widgetPlayerctl() {
	cat "$pctlTmp" 2> "/dev/null"
}

widgetIrc() {
	pgrep -f "urxvt -name irc" > /dev/null 2>&1
	if [ "$?" -ne "1" ] ; then
		echo "$padding$padding"
	else
		:
	fi
}


# loop
loop() {
	while :; do
		echo "%{l}\
		%{A4:xdotool 'set_desktop' $(expr $(xdotool 'get_desktop') - 1) &:}%{A5:xdotool 'set_desktop' '$(expr $(xdotool 'get_desktop') + 1)' &:}$(widgetDesktop)%{A}%{A}\
		$(widgetWindow)\
		%{c}\
		%{A:calendar &:}$(widgetClock)%{A}\
		%{r}\
		%{A2:cover &:}%{A:mpc 'toggle' &:}%{A3:urxvt -e 'ncmpcpp' &:}$(widgetMpd)%{A}%{A}%{A:playerctl 'play-pause' &:}$(widgetPlayerctl)$padding%{A}%{A}\
		%{A:toggle-tch &:}$(widgetIrc)%{A}"
		sleep "$refresh"
	done |\

	lemonbar \
	-f "$font" \
	-f "$font2" \
	-f "$font3" \
	-f "$font4" \
	-f "$font5" \
	-g "x$height" \
	-F "$text" \
	-B "$background" \
	-U "$acc3" \
	-u "$underline" \
	-a "20" \
	| bash
}

pctl() {
	while :; do
		pctlStatus="$(playerctl 'status' 2> '/dev/null')"
		case "$pctlStatus" in
			"Playing"|"Stopped"|"Paused")
				case "$pctlStatus" in
						"Playing")
							pctlIcon="⏸"
							;;
						"Stopped")
							pctlIcon="■"
							;;
						"Paused")
							pctlIcon="▶"
							;;
						*)
							rm "$pctlTmp" 2> "/dev/null"
							;;
				esac
				# pctlCurrent="$(playerctl 'metadata' 'artist' 2> /dev/null) : $(playerctl 'metadata' 'title' 2> /dev/null)"
				pctlCurrent="$(playerctl 'metadata' 'title' 2> /dev/null)"
				echo "$padding$pctlIcon$padding$pctlCurrent$padding" > "$pctlTmp"
				;;
			*)
				rm "$pctlTmp" 2> "/dev/null"
				;;
		esac
		sleep "2s"
	done
}

# exec
pctl &
loop