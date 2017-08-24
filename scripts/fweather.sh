#!/usr/bin/env bash

# vars
tmpf="/tmp/fweather"
station="EGSC"
temp=$(weather -qm --headers="Temperature" "$station" | sed "s/Temperature: //" | sed "s/ //")


wcond() {
	cond=$(weather -qm --headers="Sky Conditions" "$station" | sed "s/Sky conditions: //")

	if [ "$cond" == "(no conditions matched your header list, try with --verbose)" ] ; then
		cond=$(weather -qm --headers="Weather" "$station" | sed "s/Weather: //")
		echo "$cond"
	else
		echo "$cond"
	fi
}

while true ; do
	echo "$temp - $(wcond)" > "$tmpf"
	cat "$tmpf"
	sleep "15m"
done