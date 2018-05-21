#!/usr/bin/env fish


# vars
set song (mpc -f '%file%' | head -1)
set file "/tmp/cover.png"


# exec
ffmpeg -loglevel "0" \
       -y \
       -i "$HOME/Music/$song" \
       -vf scale="-200:200" \
       "$file"

if test -f "$file"
    popup "$file" "30"
else
    #
end

rm "$file"
