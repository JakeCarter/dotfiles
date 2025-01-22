#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(date '+%a %b %d%l:%M%p')" label.padding_left=10 label.padding_right=0 icon.drawing=off background.padding_left=0 background.padding_right=0

