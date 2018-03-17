#!/usr/bin/env bash
#
# This script will alert when battery is less than 20% and discharging
# Created by Daniel Neemann

while :; do 
	n=$(cat /sys/class/power_supply/BAT0/capacity)
	y=$(cat /sys/class/power_supply/BAT0/status)
	if [ "$n" -lt "10" ] && [ "$y" = "Discharging" ]; then
	    notify-send "battery level is low! - $n%"
	fi
	sleep 5m
done
