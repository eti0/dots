#!/usr/bin/env bash
# create an urxvt window

# vars
tmp="/tmp/sel"
m="10"
wd="6"
hd="19"

# exec
slop -nl -b "5" -c "1 1 1 0" > "$tmp"
sed -i 's/x/ /; s/+/ /; s/+/ /' "$tmp"

w="$(cat $tmp | awk '{print $1}')"
w="$(printf $(( ("$w" + "$m") / "$wd" )) )"
h="$(cat $tmp | awk '{print $2}')"
h="$(printf $(( ("$h" + "$m") / "$hd" )) )"
x="$(cat $tmp | awk '{print $3}')"
y="$(cat $tmp | awk '{print $4}')"

urxvt -g "$w"x"$h"+"$x"+"$y"