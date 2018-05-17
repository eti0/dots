#!/usr/bin/env fish


# funcs
function usage
		printf "usage: xbp [options]\noptions:\n    i (install)\n    s (search)\n    r (remove)\n"
		exit "1"
end


# exec
switch "$argv[1]"
	case "i"
		xbps-install $argv[2..-1]
	case "s"
		xbps-query -Rs $argv[2..-1]
	case "r"
		xbps-remove $argv[2..-1]
	case "*"
        usage
end