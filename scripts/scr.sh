#!/usr/bin/env fish


# vars
set frmt (date +%F-%T)
set path "$HOME/Pictures/Screenshots/$frmt.png"


# exec
if test "$argv" = "w"
    maim -s --hidecursor "$path"
    if test "$status" = "0"
        notify-send "window screenshot taken"
    else
        #
    end
else
    maim --hidecursor $path
    if test "$status" = "0"
        notify-send "window screenshot taken"
    else
        #
    end
end