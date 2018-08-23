#!/usr/bin/env fish


# vars
set key 43d042e6d1ed55ac9a3b36a89d07bb31
set loc "44.8158,-0.4733"
set units si
set lang en
set temp "/tmp"
set weather "$temp/weather"
set api "$temp/weather-api"
set url "https://api.darksky.net/forecast/$key/$loc?units=$units&lang=$lang"


# funcs
function fetch
    wget -q "$url" -O "$api"
end

function summary
    jq < "$api" -r ".currently.summary" | awk '{print tolower($0)}'
end

function icon
    if test (date +%H) -gt 21 ; or test (date +%H) -lt 8
        switch (summary)
            case "clear" "no precipitation"
                printf "̓"
            case "possible thunderstorms" "thunderstorms" "breezy" "windy" "dangerously windy" "foggy" "partly cloudy" "humid" "mostly cloudy" "overcast" "possible light sleet" "light sleet" "light sleet" "sleet" "heavy sleet" "possible flurries" "flurries" "snow" "heavy snow" "heavy precipitation" "rain" "heavy rain" "possible light precipitation" "light precipitation" "possible drizzle" "drizzle" "possible light rain" "light rain" "mixed precipitation"
                printf "̒"
            case *
                printf "no icon set for this forecast"
        end
    else
        switch (summary)
            case "clear" "no precipitation"
                printf "̔"
            case "mixed precipitation"
                printf "̎"
            case "possible light precipitation" "light precipitation" "possible drizzle" "drizzle" "possible light rain" "light rain"
                printf "̐"
            case "heavy precipitation" "rain" "heavy rain"
                printf "̍"
            case "possible light sleet" "light sleet" "light sleet" "sleet" "heavy sleet" "possible flurries" "flurries" "snow" "heavy snow"
                printf "̏"
            case "possible thunderstorms" "thunderstorms"
                printf "̌"
            case "breezy" "windy" "dangerously windy" "foggy"
                printf "̕"
            case "humid" "mostly cloudy" "overcast"
                printf "̋"
            case "partly cloudy"
                printf "̑"
            case *
                printf "no icon set for this forecast"
        end
    end
end

function temperature
    jq -r '.currently | .apparentTemperature | floor | tostring + "°C"' <"$api"
end

function print
    printf (temperature)\ :\ (summary) | tee "$weather"
end

function print-with-icon
    printf (temperature)\ :\ (icon) | tee "$weather"
end


# exec
fetch
if test $argv = "-i"
    print-with-icon
else
    print
end
