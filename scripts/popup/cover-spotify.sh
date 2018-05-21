#!/usr/bin/env fish


# vars
set title (sps current | sed "s/.* - //")
set artist (sps current | sed "s/ - .*//")
set file "/tmp/cover-spotify.png"


# exec
glyrc cover \
      --album "$title" \
      --artist "$artist" \
      --title "$title" \
      --write "$file" > /dev/null 2>&1

convert "$file" \
	-resize "200x200" \
	"$file" > /dev/null 2>&1

if test -f "$file"
    popup "$file" "30" > /dev/null 2>&1
else
    notify-send "spotify cover not found"
    exit "1"
end

rm "$file"
