#!/usr/bin/env bash

xrdb "$HOME/.xres/bright.xres"

urxvt -title tch -e ssh xv &
disown

sleep ".5s"

xrdb "$HOME/.Xdefaults"