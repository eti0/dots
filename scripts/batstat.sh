#!/usr/bin/env fish
# print battery information in a notification


notify-send (acpi -b | sed 's/Battery 0: //')