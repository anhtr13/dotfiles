#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/wallpaper.rasi"

source="$HOME/Pictures/wallpapers"
prompt='Wallpaper'
mesg="# Wallpaper from: ${source}"

list_col='3'
list_row='1'
win_width='960px'

if [[ ! -d "$source" ]]; then
  mkdir -p "$source"
fi

rofi_cmd() {
  rofi -theme-str "window {width: $win_width;}" \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "󰸉";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  ls $source/* \
  | while read A; do echo -en "$(basename "$A")\x00icon\x1fthumbnail://$A\n"; done \
  | rofi_cmd
}

chosen="$(run_rofi)"
swww img "$source/$chosen" --transition-fps 30 --transition-type any --transition-duration 1.5
