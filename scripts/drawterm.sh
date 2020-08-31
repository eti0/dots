#!/usr/bin/env bash


# vars
selectionFormat="%w %h %x %y"
selectionColors="0 0 0 1"
selectionBorderWidth="2"


# exec
read "width" "height" "xpos" "ypos" < <(slop -q -t "0" -lf "$selectionFormat" -b "$selectionBorderWidth" -c "$selectionColors")

[[ $width ]] || exit

alacritty &
pid=$!

xdo hide -p "$pid" -m
xdo show -p "$pid" -m
xdo move -x "$xpos" -y "$ypos" -p "$pid"
xdo resize -w "$width" -h "$height" -p "$pid"
