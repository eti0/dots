#!/usr/bin/env fish


# vars
set dir "$HOME/.covers"
set file "$dir/cover.png"
set ypos (xdotool getdisplaygeometry | awk '{print $2;}')

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
    popup "$dir/$artist - $album.png" "59" >/dev/null 2>&1 &
	n30f -t "popup-arrow" \
		 -x "40" \
		 -y (math $ypos -80) \
	 	 -c "pkill -f 'n30f -t popup-image' && pkill -f 'n30f -t popup-background' && pkill -f 'n30f -t popup-arrow'" \
		 "/usr/scripts/popup/img/arrow.png"
else
    notify-send "cover not found"
    exit "1"
end

