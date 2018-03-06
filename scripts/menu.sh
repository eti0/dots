#!/usr/bin/env bash
# symlink lemonbar to mbar first.
# requires xdotool, n30f and autism.


# fetch the colors
source "/usr/scripts/colors.sh"


# vars
p="  "
w="175"
h="40"
mx="$(xdotool "getmouselocation" | grep -oP "(?<=x:).*?(?= )")"
my="$(xdotool "getmouselocation" | grep -oP "(?<=y:).*?(?= )")"
font="-*-cure-*"


# menus
m1="urxvt"
n1="$m1"
m2="micro"
n2="urxvt -e "$m2""
m3="ncmpcpp"
n3="urxvt -e "$m3""
m4="pcmanfm"
n4="$m4"
m5="chromium"
n5="$m5"


# func
menu() {
	while :; do
		echo "%{A:"$nprog" & killall "mbar":}%{+o}%{+u}$p $prog $tw %{A}"
		sleep "256"
	done |\

	mbar \
	  	-g $w\x$h\+$mx\+$my \
		-f "$font" \
 		-B "$text" \
 		-F "$background" \
	| bash
}


# exec
killall "mbar" &

export my="$(expr "$my" + "0")"
export prog="$m1"
export nprog="$n1"
menu &

export my="$(expr "$my" + "$h")"
export prog="$m2"
export nprog="$n2"
menu &

export my="$(expr "$my" + "$h")"
export prog="$m3"
export nprog="$n3"
menu &

export my="$(expr "$my" + "$h")"
export prog="$m4"
export nprog="$n4"
menu &

export my="$(expr "$my" + "$h")"
export prog="$m5"
export nprog="$n5"
menu