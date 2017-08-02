#!/usr/bin/env bash

# fetch the colors from colors.sh
source "/usr/scripts/colors.sh"

/usr/scripts/barinfo.sh | lemonbar \
    -f '-x-vanilla-*' \
    -f '-wuncon-siji-*' \
    -g "x30" \
    -B "$bgn" \
    | sh