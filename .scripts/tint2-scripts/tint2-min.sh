#!/bin/bash

# Kill tint2 instances
killall tint2

# Use taskbar = Off
tint2 -c ~/.config/tint2/tint2rc-minimal
