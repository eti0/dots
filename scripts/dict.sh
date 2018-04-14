#!/usr/bin/env bash
# vars
www="http://www.dictionary.com/browse"
word="$1"

# funcs
get() {
	cmd=$(curl -s "$www/$word" | grep -oP '(?<=<meta name="description" content=").*(?=See more.)' | sed "s/.*definition,/$word:/")
	if [ "$cmd" == "" ] ; then
		printf "this word wasn't found. \n"
		exit "1"
	else
		printf "$cmd \n"
	fi
}

usage() {
	printf "usage: \n    dict <word> \n    requires curl, grep and sed. \n"
	exit "1"
}

# exec
if [[ "$@" == "" ]] ; then
	usage
else
	get
fi