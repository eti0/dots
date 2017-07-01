#!/usr/bin/env fish
#
# no rice no life - display stuff that nobody cares about
#

# set the colors
set fg normal
set c1 brblue
set c2 brred

# set the variables
set hostname (hostname)
set kernel (uname -r -s)
set shell (basename $SHELL)
set os "arch"
set packages (pacman -Q | wc -l)
set wm "openbox"


## EXECUTE

echo
echo (set_color $fg) "┌───╮ │" (set_color $c1)"os:"(set_color $fg)"        $os"
echo (set_color $fg) "│"(set_color $c2)"•‿•"(set_color $fg)"│ │" (set_color $c1)"shell:"(set_color $fg)"     $shell"
echo (set_color $fg) "╰───┘ │" (set_color $c1)"wm:"(set_color $fg)"        $wm"
echo
