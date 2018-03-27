#!/usr/bin/env bash

mw="$(xdotool "getdisplaygeometry" | awk '{print $1;}')"
mh="$(xdotool "getdisplaygeometry" | awk '{print $2;}')"

ww="$(xdotool "getwindowgeometry" "$(xdotool "getactivewindow")" | awk -v FS="(Geometry: | )" '{print $4}' | tail -n1 | sed "s/x.*//")"
wh="$(xdotool "getwindowgeometry" "$(xdotool "getactivewindow")" | awk -v FS="(Geometry: | )" '{print $4}' | tail -n1 | sed "s/.*.x//")"

mw="$(($mw / "2"))"
mh="$(($mh / "2"))"
ww="$(($ww / "2"))"
wh="$(($wh / "2"))"

x="$(expr "$mw" - "$ww")"
y="$(expr "$mh" - "$wh")"

xdotool "windowmove" "$(xdotool "getactivewindow")" "$x" "$y"