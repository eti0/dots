#!/usr/bin/env bash
# simple script to upload to your host


# server
host="host"
usr="user"
pswd="password"


# fetch the file extension of $1
flnm=$(basename "$1")
fext="${flnm##*.}"


# generate a random string
string=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1`

echo "$string" > "/tmp/hop"

rfn=`cat /tmp/hop`
gst=""$rfn"."$fext""


# execute
ncftp -u "$usr" -p "$pswd" "$host" &> /tmp/hop.log << X

put -z "$1" "$gst"

bye

X


# print the link
echo "http://$host/"$gst""