#!/usr/bin/env bash
# requires urxvt, slop & xdotool


# vars
borderWidth="0"
selectionFormat="%w %h %x %y"
selectionColors="0 0 0 1"
selectionBorderWidth="2"


# exec
urxvt -iconic -name "drawterm" &
read "width" "height" "xpos" "ypos" < <(slop -t "0" -lf "$selectionFormat" -b "$selectionBorderWidth" -c "$selectionColors")

if [ "$width" ] ; then
    :
else
    pkill -nf "urxvt -iconic -name drawterm"
    exit "1"
fi

# adapt to the border width of your windows
((width -= $borderWidth))
((height -= $borderWidth))

active="$(xdotool 'search' --sync --classname 'drawterm' | tail -n1)"

xdotool "windowmove" "$active" "$xpos" "$ypos"
xdotool "windowsize" "$active" "$width" "$height"
xdotool "windowactivate" "$active"