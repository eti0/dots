#!/usr/bin/env fish
# center the focused window


# vars
set aw (xdotool "getactivewindow")
set dg (xdotool "getdisplaygeometry")

set mw (printf "$dg" | awk '{print $1;}')
set mh (printf "$dg" | awk '{print $2;}')

set ww (xdotool "getwindowgeometry" "$aw" | awk -v FS="(Geometry: | )" '{print $4}' | tail -n1 | sed "s/x.*//")
set wh (xdotool "getwindowgeometry" "$aw" | awk -v FS="(Geometry: | )" '{print $4}' | tail -n1 | sed "s/.*.x//")

set mw (math "$mw" / "2" )
set mh (math "$mh" / "2" )
set ww (math "$ww" / "2" )
set wh (math "$wh" / "2" )

set x (math "$mw" - "$ww")
set y (math "$mh" - "$wh")

set y (math "$y" - 10)


# exec
xdotool "windowmove" "$aw" "$x" "$y"