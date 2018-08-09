#!/usr/bin/env fish


# vars
set www "http://www.dictionary.com/browse"
set word "$argv"
set cmd (wget -qO - "$www/$word" | grep -oP '(?<=<meta name="description" content=").*(?=See more.)' | sed "s/.*definition,/$word:/")


# funcs
function get
	if test -z "$cmd"
		printf "this word wasn't found.\n"
		exit "1"
	else
		printf "$cmd\n"
	end
end

function usage
	printf "usage: dict <word>\nrequires wget, grep and sed.\n"
	exit "1"
end


# exec
if test -z "$argv"
	usage
else
	get
end