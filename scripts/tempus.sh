#!/usr/bin/env bash
# vars
hour="$(date "+%H")"
minute="$(date "+%M")"

hourSuffix="heures"
hourStr=( "minuit" "une" "deux" "trois" "quatre" "cinq" "six" "sept" "huit" "neuf" "dix" "onze" "midi" )
minuteStr=( "" "-et-une" "-deux" "-trois" "-quatre" "-cinq" "-six" "-sept" "-huit" "-neuf" )
minuteTenthsStr=( "dix" "onze" "douze" "treize" "quatorze" "quinze" "seize" "dix-sept" "dix-huit" "dix-neuf" )
minuteHiTenthsStr=( "vingt" "trente" "quarante" "cinquante" )

# exec
if [[ "$hour" -gt "12" ]] ; then
    hour="$(($hour - 12))"
fi

hourToPrint="${hourStr["$hour"]} "${hourSuffix}""

case $hour in
    "00" | "12" )
        hourToPrint="${hourToPrint//$hourSuffix}"
        hourToPrint="${hourToPrint//\ }" ;;
    "01" | "1" )
        hourToPrint="${hourToPrint//s}" ;;
esac

case "${minute:0:1}" in
    "0" )
        minuteToPrint="${minuteStr["${minute:1:2}"]}"
        minuteToPrint="${minuteToPrint//-et-}"
        minuteToPrint="${minuteToPrint//-}" ;;
    "1" )
        minuteToPrint="${minuteTenthsStr["${minute:1:2}"]}" ;;
    "2" | "3" | "4" | "5" )
        minuteToPrint="${minuteHiTenthsStr["$((${minute:0:1} - 2))"]}"${minuteStr["${minute:1:2}"]}"" ;;
esac

printf "${hourToPrint} ${minuteToPrint}\n"