#!/usr/bin/env bash

cd "/home/eti/Music/yt"

youtube-dl -x --audio-format "mp3" "$@"