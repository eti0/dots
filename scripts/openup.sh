#!/usr/bin/env fish
# a small program to determinate which tool should be used to open a link


# vars
set url $argv
set tmp "/tmp/file"
set short (curl -sLI $url | grep 'Location' | sed 's/Location: //')


# funcs
function short
    if test -z $short
        echo "url isn't shortened"
    else
        echo "shortened url leading to: $short"
        set -x url $short
    end
end

function download
    wget $url -O $tmp
end

function video
    urxvt -g 100x10 -e mpv --keep-open=no $url
end

function audio
    urxvt -g 100x10 -e mpv --keep-open=no $url
end

function text
    subl $url
end

function pic
    sxiv -ab $tmp
end

function other
    chromium $url
end


# exec
short

# laziness
set ext (echo $url | sed 's/^.*\.//;s/?.*//')

switch $ext
    case png jpg jpeg gif tif
        other
    case aac mp3
        audio
    case mp4 avi mkv webm
        video
    case '*'
        other
        exit 1
end
