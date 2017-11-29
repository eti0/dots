#!/usr/bin/env bash


# grab the colors
if [ "$1" == "-o" ] ; then
	:
elif [ "$(which /usr/scripts/colors.sh)" ] ; then
	source "/usr/scripts/colors.sh"
else
	printf "no colors.sh\nuse \"-o\" to omit.\n"
	exit 1
fi


# vars
key="43d042e6d1ed55ac9a3b36a89d07bb31"
loc="44.8378,-0.5792"
units="si"
temp="$(curl -s "https://api.darksky.net/forecast/$key/$loc?units=$units" | grep -oP "(?<=temperature\"\:).*?(?=,\"apparentTemperature)" | sed "s/\..*\$/°C/" | head -n1)"
cond="$(curl -s "https://api.darksky.net/forecast/$key/$loc?units=$units" | grep -oP "(?<=summary\"\:\").*?(?=\",\"icon)" | head -n1 | tr "[:upper:]" "[:lower:]")"
file="/tmp/weather"


# define ico
icon() {
	if [[ "$cond" == "light rain" || "$cond" == "drizzle" ]] ; then
		ico=""
		printf "$ico"
	elif [ "$cond" == "showers" ] ; then
		ico=""
		printf "$ico"
	elif [[ "$cond" == "mostly cloudy" ||  "$cond" == "partly cloudy" || "$cond" == "mostly clear"  ]] ; then
		ico=""
		printf "$ico"
	elif [[ "$cond" == "overcast" || "$cond" == "obscured" ]] ; then
		ico=""
		printf "$ico"
	elif [ "$cond" == "clear" ] ; then
		ico=""
		printf "$ico"
	elif [ "$cond" == "foggy" ] ; then
	 	ico=""
		printf "$ico"
	else
		:
	fi
}


# exec
if [ "$(icon)" == "" ] ; then
	echo "$temp - $cond" > "$file"
	cat "$file"
else
	echo "$af0$(icon)$txt $temp - $cond" > "$file"
	cat "$file"
fi