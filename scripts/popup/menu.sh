#!/usr/bin/env bash

# quit on error
set -e

# vars
pointer="/usr/scripts/popup/img/pointer.png"
menu="/usr/scripts/popup/img/menu.png"
height=$(xdotool "getdisplaygeometry" | awk '{print $2;}')
ypos=$(expr "$height" - "242")
item="/usr/scripts/popup/img/menu-items/"


# exec
# background & pointer
n30f -t "background" -x "14" -y "$(expr "$height" - "184")" -c "killall n30f" "$menu" &
n30f -t "pointer" -x "33" -y "$(expr "$ypos" + "204")" -c "killall n30f" "$pointer" &

sleep ".05s"

n30f -t "menu" -x "34" -y "$(expr "$height" - "68")" -c "chromium & killall n30f" "$item/web.png" &
n30f -t "menu" -x "34" -y "$(expr "$height" - "88")" -c "cd $HOME && urxvtc & killall n30f" "$item/term.png" &
n30f -t "menu" -x "34" -y "$(expr "$height" - "108")" -c "pcmanfm -n $HOME & killall n30f" "$item/files.png" &
n30f -t "menu" -x "34" -y "$(expr "$height" - "128")" -c "obconf & killall n30f" "$item/obconf.png" &
n30f -t "menu" -x "34" -y "$(expr "$height" - "148")" -c "feh --randomize --bg-fill $HOME/ownCloud/Wallpapers & killall n30f" "$item/random.png" &
n30f -t "menu" -x "34" -y "$(expr "$height" - "168")" -c "pavucontrol & killall n30f" "$item/pavucontrol.png" &