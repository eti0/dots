#!/usr/bin/env bash
# vars
www="http://www.dictionary.com/browse"
word="$@"

# funcs
get() {
	cmd=$(curl -s "$www/$word" | grep -oP '(?<=<meta name="description" content=").*(?=See more.)' | sed "s/.*definition,/$word:/")	
	
	if [ -z "$cmd" ] ; then
		printf "this word wasn't found.\n"
		exit "1"
	else
		printf "$cmd\n"
	fi
}

usage() {
	printf "usage: dict <word>\nrequires curl, grep and sed.\n"
	exit "1"
}

# exec
if [ -z "$@" ] ; then
	usage
else
	get
fi