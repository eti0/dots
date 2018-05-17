#!/usr/bin/env fish


# vars
set fontdir "$HOME/.fonts"


# exec
mkfontdir "$fontdir"

cp "$fontdir/fonts.dir" "$fontdir/fonts.alias"
sed -i "1d;s/.pcf.gz//;s/.pcf//;s/.bdf//" "$fontdir/fonts.alias"

xset fp+ "$fontdir"
xset fp rehash

printf "done!\n"