#!/usr/bin/env bash

mkfontdir ~/.fonts

cp "$HOME/.fonts/fonts.dir" "$HOME/.fonts/fonts.scale"
sed -i "1d;s/.pcf.gz//;s/.pcf//" "$HOME/.fonts/fonts.alias"

xset fp+ ~/.fonts
xset fp rehash

echo "done!"