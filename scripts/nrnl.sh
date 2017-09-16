#!/usr/bin/env sh
#
# nrnl.sh - displays sys info

# colors (algorithm by lolilolicon)
f=3 b=4
for j in f b; do
	for i in {0..7}; do
		printf -v $j$i "%b" "\e[${!j}${i}m"
	done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

# detect
user=$(whoami)
host=$(hostname)
kernel=$(uname -r)
shell=$(basename $SHELL)
os() {
	os=$(find /etc -mindepth 1 -maxdepth 1 ! -type l | grep release)
	os=${os##*/}
	os=${os%-*}
	export os
}
wm() {
	id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
	id=${id##* }
	wm=$(xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t)
	wm=${wm/*_NET_WM_NAME = }
	wm=${wm/\"}
	wm=${wm/\"*}
	wm=${wm,,} # use this to output in lowercase
	export wm
}
init() {
	init=$(readlink /sbin/init)
	init=${init##*/}
	export init
}

# exec
os
wm
init
cat <<EOF

$user$f2@$rst$host

         ${f2}os${rst}:          ${os}
┌───┐    ${f2}kernel${rst}:      ${kernel}
│${f2}•˩•${rst}│    ${f2}shell${rst}:       $shell
└───┘    ${f2}init${rst}:        $init
         ${f2}wm${rst}:          $wm

EOF
