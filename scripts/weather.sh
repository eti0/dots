#!/usr/bin/env fish


# vars
set key 43d042e6d1ed55ac9a3b36a89d07bb31
set loc "44.8378,-0.5792"
set units si
set temp "/tmp"
set weather "$temp/weather"
set api "$temp/weather-api"
set url "https://api.darksky.net/forecast/$key/$loc?units=$units&lang=fr"


# funcs
function fetch
    wget -q $url -O $api
end

function summary
    jq < $api -r ".currently.summary"
end

function temperature
    set temp (jq < $api -r ".currently.apparentTemperature")
    printf $temp | sed "s/\..*\$/°C/"
end

function print
    printf (temperature)\ -\ (summary) | tee $weather
end


# exec
fetch
print
