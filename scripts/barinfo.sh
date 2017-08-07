#!/usr/bin/env bash
# requires https://github.com/stark/siji installed to display icons


# fetch the colors from colors.sh
source "/usr/scripts/colors.sh"


# define the padding size
padding="  "


clock() {
	datetime=$(date "+%a %R")
	echo $accent$text $datetime
}

cputemp() {
	temp=$(cat /sys/class/thermal/thermal_zone0/temp | cut -c -2)
	if [ "$temp" -ge "60" ]; then
		echo $warning$text $temp°
	else
		echo $accent$text $temp°
	fi
}

sound() {
	level=$(amixer get Master 2>&1 | awk '/Front Left:/{gsub(/[\[\]]/, "", $5); print $5}')
	if [ "$level" == "0%" ]; then
		echo $accent$text muted
	else
		echo $accent$text $level
	fi
}


song() {
	csong=$(mpc current)
	playing=$(mpc status | grep -o 'playing')

	if [ "$playing" == "playing" ]; then
		echo $accent$text $csong
	else [ "$playing" == "" ];
		echo ''
	fi
}


workspace() {
	number=$(xdotool get_desktop | cut -c34)
	wicon="$accent$text"

	if [ "$number" = "0" ] ; then
		echo "$wicon" "one"
	elif [ "$number" = "1" ] ; then
		echo "$wicon" "two"
	elif [ "$number" = "2" ] ; then
		echo "$wicon" "three"
	elif [ "$number" = "3" ] ; then
		echo "$wicon" "four"
	elif [ "$number" = "4" ] ; then
		echo "$wicon" "five"
	else
		echo "$number"
	fi
}


desktops() {
	cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
	tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

	for w in `seq 0 $((cur - 1))`; do line="${line}$text◽ "; done
	line="${line}$accent◾"
	for w in `seq $((cur + 2)) $tot`; do line="${line}$text ◽"; done
	echo $line
}


network() {
	cnetwork=$(iwgetid -r)

	if [ "$cnetwork" == "" ]; then
		echo $warning$text offline
	else
		echo $accent$text $cnetwork
	fi
}


battery() {
    percent=$(cat /sys/class/power_supply/BAT0/capacity)
    power=$(cat /sys/class/power_supply/BAT0/status)
	
	if [[ $power == "Charging" || $power == "Unknown" ]]; then
		echo -n "$accent$text $percent%"
	else
		if [ $percent -eq 100 ]; then
			echo -n "$accent$text $percent%"
		elif [ $percent -gt 80 ] ; then
			echo -n "$accent$text $percent%"
		elif [ $percent -gt 50 ]; then
			echo -n "$accent$text $percent%"
		else 
			echo -n "$accent$text $percent%"
		fi
	fi
}

# not finished - can't be bothered
weather() {
	meteo=$(cat "/tmp/meteo.txt")

	if [ "$meteo" == "mostly clear" ] ; then
		echo $accent""$text "$meteo"
	elif [ "$meteo" == "mostly clear" ] ; then
		echo $accent""$text "$meteo"
	elif [ "$meteo" == "mostly clear" ] ; then
		echo $accent""$text "$meteo"
	else
		echo "no"
	fi
}

window() {
	cwindow=$(xdotool "getwindowfocus" "getwindowname" | head -c70)

	if [ "$cwindow" == "Openbox" ] ; then
		echo ""
	else
		echo $accent$text $cwindow
	fi
}


while true ; do
	echo "%{l}$padding$(desktops)$padding%{A:cover.sh:}$(song)%{A}$bgc%{A:popup.sh "term" "ncmpcpp" "80x20+481+40":}%{A3:mpc toggle:}ወወወ%{A}%{A} \
	      %{c}%{A:calendar.sh:}$(clock)%{A} \
	      %{r}$(window)$padding%{A:popup.sh "term" "nmtui" "60x25+1056+40":}$(network)%{A}$padding%{A:popup.sh "term" "alsamixer" "60x25+1056+40":}$(sound)%{A}$padding$(battery)$padding"
	sleep ".3s"
done
