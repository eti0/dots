#!/usr/bin/env fish


# vars
set key 43d042e6d1ed55ac9a3b36a89d07bb31
set loc "44.8158,-0.4733"
set units si
set temp "/tmp"
set weather "$temp/weather"
set api "$temp/weather-api"
set url "https://api.darksky.net/forecast/$key/$loc?units=$units&lang=fr"


# funcs
function fetch
    wget -q "$url" -O "$api"
end

function summary
    jq < "$api" -r ".currently.summary" | awk '{print tolower($0)}'
end

function temperature
    jq -r '.currently | .apparentTemperature | floor | tostring + "°C"' <"$api"
end

function print
    printf (temperature)\ :\ (summary) | tee "$weather"
end


# exec
fetch
print
