cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

for w in `seq 0 $((cur - 1))`; do line="${line} ◽"; done
line="${line} %{F#eee}◾%{F#DFC39B}"
for w in `seq $((cur + 2)) $tot`; do line="${line} ◽"; done
echo $line
