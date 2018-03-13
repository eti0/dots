#!/usr/bin/env bash
# create an urxvt window

# vars
m="10"
wd="6"
hd="15"

# exec
read "w" "h" "x" "y" < <(slop -nl -b "5" -c "1 1 1 0" -f "%w %h %x %y")

w="$(printf $(( ("$w" + "$m") / "$wd" )) )"
h="$(printf $(( ("$h" + "$m") / "$hd" )) )"

urxvt -g "$w"x"$h"+"$x"+"$y"
