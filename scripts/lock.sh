#!/usr/bin/env bash
# credits go to vsrch

icon="/usr/scripts/lock/lock.png"
scr="/tmp/screen.png"
fscr="/tmp/screen.jpg"

(( $# )) && { icon=$1; }

# take a screenshot
maim "$scr"

# blur the screenshot and add the lock icon to it
convert "$scr" -blur "0x8" -quality "0" "$fscr"
convert "$fscr" "$icon" -gravity "center" -composite -matte -quality "0" "$scr"

# execute the i3lock
i3lock -u -i "$scr"

# remove the file when done
rm "$scr" "$fscr"