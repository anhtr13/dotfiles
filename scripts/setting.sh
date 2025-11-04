#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Setting'
mesg="# General setting."

list_col='1'
list_row='6'

cmd_wallpaper='sh ~/.config/scripts/wallpaper.sh'
cmd_waybar='sh ~/.config/scripts/waybar.sh'

option_wallpaper="󰸉 Change wallpaper"
option_waybar=" Change waybar style"

rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  echo -e "$option_wallpaper\n$option_waybar" | rofi_cmd
}

run_cmd() {
  case $1 in
  "--wallpaper")
    eval ${cmd_wallpaper}
    ;;
  "--waybar")
    eval ${cmd_waybar}
    ;;
  esac
}

chosen="$(run_rofi)"
case "$chosen" in
$option_wallpaper)
  run_cmd --wallpaper
  ;;
$option_waybar)
  run_cmd --waybar
  ;;
esac
