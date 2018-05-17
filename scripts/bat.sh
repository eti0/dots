#!/usr/bin/env fish
# alerts the user when the battery level is low | original script created by Daniel Neemann


# vars
set c (cat "/sys/class/power_supply/BAT0/capacity")
set s (cat "/sys/class/power_supply/BAT0/status")


# exec
while true
	if test "$c" -lt "20" ; and test "$s" != "Charging"
		notify-send "battery level low! - $c%"
	else
		#
	end
	sleep "5m"
end