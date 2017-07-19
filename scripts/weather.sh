#!/usr/bin/env bash
# fetch current weather

nline=(echo)
location="Cambridge"

$nline

curl -sL "wttr.in/$location?0QT"

$nline