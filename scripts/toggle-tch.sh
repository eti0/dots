#!/usr/bin/env fish


# vars
set tmp "/tmp"
set window (xdotool search --sync --classname irc)
set windesktop (xdotool get_desktop_for_window $window)
set oldwindesktop (cat $tmp/windesktop)
set desktop (xdotool get_desktop)


# exec
if test ! $desktop -eq $windesktop
    printf $windesktop > $tmp/windesktop
    echo "the window isn't on the same desktop"
    xdotool set_desktop_for_window $window $desktop
else
    printf $windesktop > $tmp/windesktop
    echo "the window is on the same desktop"
end

if test ! $windesktop -eq $oldwindesktop
    echo "the window isn't on the same desktop as before"
    echo "irc is the window that's currently selected"
    xdotool set_desktop_for_window $window $oldwindesktop
    rm $tmp/windesktop
else
    echo "the window is on the same desktop as before"
    if test $window -eq (xdotool getactivewindow)
        echo "irc is the window that's currently selected"
        xdotool windowminimize $window
    else
        echo "irc isn't the window that's currently selected"
        xdotool windowactivate $window
    end
end
