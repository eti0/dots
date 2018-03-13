#!/usr/bin/env bash
# create an urxvt window

# vars
wd="6"
hd="15"

# exec
read "w" "h" "x" "y" < <(slop -l -b "5" -c "1 1 1 0" -f "%w %h %x %y")

w="$(printf $(( "$w" / "$wd" )) )"
h="$(printf $(( "$h" / "$hd" )) )"

urxvt -g "$w"x"$h"+"$x"+"$y"
