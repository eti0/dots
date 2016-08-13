#!/bin/bash

# Kill tint2 instances
killall tint2

# Use taskbar = Off
tint2 -c /home/eti/.config/tint2/tint2rc-no-apps
