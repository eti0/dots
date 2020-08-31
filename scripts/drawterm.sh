#!/usr/bin/env bash


# vars
selectionFormat="%w %h %x %y"
selectionColors="0 0 0 1"
selectionBorderWidth="2"


# exec
read "width" "height" "xpos" "ypos" < <(slop -q -t "0" -lf "$selectionFormat" -b "$selectionBorderWidth" -c "$selectionColors")

[[ $width ]] || exit

alacritty --position "$xpos" "$ypos" &
pid=$!

xdo resize -w "$width" -h "$height" -p "$pid" -m

wait
