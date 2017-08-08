#!/usr/bin/env bash

# fetch the colors from colors.sh
source "/usr/scripts/bar/colors.sh"

/usr/scripts/bar/bar.sh | lemonbar \
    -f '-x-vanilla-*' \
    -f '-wuncon-siji-*' \
    -g "x30" \
    | bash