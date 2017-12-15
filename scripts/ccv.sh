#!/usr/bin/env bash
# quickly check a cryptocoin value


# vars
# urls
ethurl="https://ethereumprice.org"
btcurl="https://ethereumprice.org/btc/"
ltcurl="https://ethereumprice.org/ltc/"

# tmp
btctmp="/tmp/btc"
ethtmp="/tmp/eth"
ltctmp="/tmp/ltc"

# strings
str0="<span id=\"ep-price\">"
str1="</span>"
prc0="<span id=\"ep-percent-change\">"
prc1="</span>"

# colors
rst="\e[0m"
ylw="\e[33m"
blu="\e[34m"
dgr="\e[90m"
lgr="\e[37m"

# misc
hold="$2"


# funcs
fetch() {
	# hide the cursor
	tput civis
	
	# BTC
	url="$btcurl"
	curl -s "$url" > "$btctmp"
	cur="$(cat "$btctmp" | grep -oP "(?<=$str0).*?(?=$str1)")"
	prc="$(cat "$btctmp" | grep -oP "(?<=$prc0).*?(?=$prc1)")"
	printf ""$ylw"BTC:"$rst" \$$cur "$dgr"-"$rst" $prc%% \n"
	rm "$btctmp"
	
	# ETH
	url="$ethurl"
	curl -s "$url" > "$ethtmp"
	cur="$(cat "$ethtmp" | grep -oP "(?<=$str0).*?(?=$str1)")"
	prc="$(cat "$ethtmp" | grep -oP "(?<=$prc0).*?(?=$prc1)")"
	printf ""$blu"ETH:"$rst" \$$cur "$dgr"-"$rst" $prc%% \n"
	rm "$ethtmp"
	
	# LTC
	url="$ltcurl"
	curl -s "$url" > "$ltctmp"
	cur="$(cat "$ltctmp" | grep -oP "(?<=$str0).*?(?=$str1)")"
	prc="$(cat "$ltctmp" | grep -oP "(?<=$prc0).*?(?=$prc1)")"
	printf ""$lgr"LTC:"$rst" \$$cur "$dgr"-"$rst" $prc%% \n"
	rm "$ltctmp"

	# show the cursor
	tput cnorm
}

loop() {
	while :; do	
		# clear the window
		printf "\033c"

		# fetch the values
		fetch

		# hide the cursor
		tput civis

		# wait
		printf "$dgr\0refreshing the values in $hold seconds...$rst"
		sleep "$hold"
		
		# clear the window again
		printf "\033c"
	done
}

usage() {
	printf "usage: ccv [options]
options:
	-l [seconds] (loop)
	-h (show this screen)\n"
	exit 0
}


# exec
# show the cursor even on quit
trap "tput cnorm && exit 1" INT

if [ "$1" = "-l" ] ; then
	loop
elif [ "$1" = "-h" ] ; then
	usage
else
	fetch
fi