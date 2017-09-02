#!/usr/bin/env bash

cd "/home/eti/Music/dl/yt"

youtube-dl -x --audio-format "mp3" "$@"