#!/usr/bin/env fish


# vars
set dir "$HOME/.covers"
set file "$dir/cover.png"

if test (pidof spotify)
    set title (sps current | sed "s/.* - //")
    set artist (sps current | sed "s/ - .*//")
    set album (sps album)
else
    set title (mpc current -f "%title%")
    set artist (mpc current -f "%artist%" | sed "s/;.*//")
    set album (mpc current -f "%album%")
end


# exec
if test -f "$dir/$artist - $album.png"
    set file "$dir/$artist - $album.png"
else
    notify-send "looking for a cover"
    glyrc cover --album "$album" --artist "$artist" --title "$title" --write "$file"
    convert "$file" -resize "200x200" "$file" >/dev/null 2>&1
    cp "$file" "$dir/$artist - $album.png"
    rm "$file"
end

if test -f "$dir/$artist - $album.png"
    popup "$dir/$artist - $album.png" "30" >/dev/null 2>&1
else
    notify-send "spotify cover not found"
    exit "1"
end

