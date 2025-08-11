#!/bin/bash

CONFIG_FILE="$HOME/.config/waybar/base/config.jsonc"
STYLE_FILE="$HOME/.config/waybar/base/style.css" # Add if you also want to monitor style changes

cleanup() {
  pkill waybar
}

trap cleanup EXIT

while true; do
  inotifywait -e modify "$CONFIG_FILE" "$STYLE_FILE" # Watch both config and style
  pkill waybar
  waybar &
done
