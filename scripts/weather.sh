#!/usr/bin/env bash
# fetch current weather

nline=(echo)
location="Bordeaux"

$nline

curl -sL "wttr.in/$location?0QT"

$nline