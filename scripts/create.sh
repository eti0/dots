#!/usr/bin/env bash
# create an urxvt window plan9-style
# requires slop and xdotool

# exec
read "w" "h" "x" "y" < <(slop -l -b "5" -c "1 1 1 0" -f "%w %h %x %y")

urxvt -g +"$x"+"$y" &
sleep ".1"
xdotool windowsize "$(xdotool "getactivewindow")" "$w" "$h"