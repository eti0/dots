#!/usr/bin/env fish

xrdb "$HOME/.xres/tch.xres"

urxvt -name "irc" &
disown

sleep ".5s"

xrdb "$HOME/.Xdefaults"