#!/usr/bin/env bash

cd "/tmp"

scdl --onlymp3 -l "$1"

mv "$(ls --sort "time" -1 | head -n1)" "/home/eti/Music/dl/"