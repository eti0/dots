#!/usr/bin/env bash
# vars
www="http://www.dictionary.com/browse"
word="$@"
tmp="/tmp/dico"
tmpv="/tmp/dico.wav"

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

vox() {
	get > "$tmp"
	cat "$tmp"
	flite -voice "slt" -f "$tmp" -o "$tmpv"
	ffplay -nodisp -autoexit -loglevel "panic" "$tmpv"
}

usage() {
	printf "usage: dict [options] <word>\n	options:\n	-v: read the definition with text to speech. \nrequires curl, grep and sed.\ninstall ffmpeg and flite to use the -v option. \n"
	exit "1"
}

# exec
if [[ "$@" == "" ]] ; then
	usage
elif [[ "$1" == "-v" ]] ; then
	word="${@:2}"
	vox
else
	get
fi