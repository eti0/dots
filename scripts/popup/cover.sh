#!/usr/bin/env fish


# vars
if test (pidof spotify)
    set title (sps current | sed "s/.* - //")
    set artist (sps current | sed "s/ - .*//")
    set album (sps album)
else
    set title (mpc current | sed "s/.* - //")
    set artist (mpc current | sed "s/ - .*//;s/;.*//")
    set album (mpc current -f "%album%")
end

set file "/tmp/cover.png"

# exec
if test -f "/tmp/$artist - $album.png"
    set file "/tmp/$artist - $album.png"
else
    glyrc cover --album "$album" --artist "$artist" --title "$title" --write "$file"
    convert "$file" -resize "200x200" "$file" >/dev/null 2>&1
    cp "$file" "/tmp/$artist - $album.png"
end

if test -f "$file"
    popup "$file" "30" >/dev/null 2>&1
else
    notify-send "spotify cover not found"
    exit "1"
end

