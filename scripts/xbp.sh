#!/usr/bin/env fish


# exec
switch "$argv[1]"
	case "i"
		xbps-install $argv[2..-1]
	case "s"
		xbps-query -Rs $argv[2..-1]
	case "r"
		xbps-remove $argv[2..-1]
	case "*"
		printf "you didn't provide any argument you dumbfuck.
	usage: xbp [options]
	options:
	  i (install)
	  s (search)
	  r (remove)\n"
		exit "1"
end