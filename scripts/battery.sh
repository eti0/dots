#!/usr/bin/env fish
# alerts the user when the battery level is low | original script created by Daniel Neemann


# vars
set battery "BAT0"
set c (cat /sys/class/power_supply/$battery/capacity)
set s (cat /sys/class/power_supply/$battery/status)


# exec
while true
	if test "$c" -lt "20" ; and test "$s" != "Charging"
		notify-send "battery level low! - $c%"
	else
		#
	end
	sleep "5m"
end