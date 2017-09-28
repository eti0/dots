#!/usr/bin/env bash
# toggle the bar

pid=$(pidof lemonbar)

if [ $pid ]; then
	sed -i "s/<top>60<\/top>/<top>30<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure
	kill -9 "$pid"
else
	sed -i "s/<top>30<\/top>/<top>60<\/top>/g" "$HOME/.config/openbox/rc.xml"
	openbox --reconfigure
	/usr/scripts/bar.sh &
fi