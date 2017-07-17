#!/usr/bin/env fish
#
# no rice no life - display stuff that nobody cares about
#


# set the colors - change this to your liking
set fg (set_color normal)
set c1 (set_color yellow)
set c2 (set_color white)


# set the variables
set user (whoami)
set host (hostname)
set userinf "$user"$c1"@"$fg"$host"
set kernel (uname -r)
set shell (basename $SHELL)
set os "void"
set wm "openbox"
set init "runit"


# execute everything
echo
echo $userinf
echo $c1"	os"$fg":        $os"
echo "┌───╮ "$c1"	kernel"$fg":    $kernel"
echo "│"$c1"•˩•"$fg"│"$c1"	shell"$fg":     $shell"
echo "╰───┘"$c1"	init"$fg":      $init"
echo $c1"	wm"$fg":        $wm"
echo