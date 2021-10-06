#!/usr/bin/env bash

# Terminate already running bar instances
pkill --signal QUIT polybar

# Launch top bar
echo "---" | tee -a /tmp/polybar-top-right.log
echo "---" | tee -a /tmp/polybar-top-left.log

polybar top -c ~/.config/polybar/config-right 2>&1 | tee -a /tmp/polybar-top-right.log & disown
polybar top -c ~/.config/polybar/config-left 2>&1 | tee -a /tmp/polybar-top-left.log & disown

echo "Bars launched..."
