#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

source="$XDG_CONFIG_HOME/waybar/styles"
target="$XDG_CONFIG_HOME/waybar/style.css"
prompt='Waybar styles'
mesg="# $source"

list_col='1'
list_row='5'
win_width='480px'

if [[ ! -d "$source" ]]; then
  mkdir -p "$source"
fi

rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  ls $source/* |
    while read A; do echo -en "$(basename "$A")\n"; done |
    rofi_cmd
}

chosen="$(run_rofi)"
if [[ -f "$source/$chosen" ]]; then
  cat "$source/$chosen" >$target
fi
