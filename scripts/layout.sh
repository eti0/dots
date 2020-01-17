#!/usr/bin/env fish
# change the keyboard layout

set current (setxkbmap -query | awk 'END { print $2 }')

switch $current
    case us
        set new fr
    case fr
        set new us
    case *
        set new us
end

setxkbmap $new
notify-send keymap\ changed\ to\ $new
