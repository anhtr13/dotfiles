#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Screenshot'
mesg="DIR: $HOME/Desktop/Pictures/Screenshots"

list_col='1'
list_row='5'
win_width='480px'

option_screen="󰹑 Capture screen"
option_region="󰆞 Capture region"
option_window=" Capture window"

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
  echo -e "$option_screen\n$option_window\n$option_region" | rofi_cmd
}

time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/Screenshots"
file_name="Screenshot_${time}.png"
file_path="$dir/$file_name"

if [[ ! -d "$dir" ]]; then
  mkdir -p "$dir"
fi

takeshot() {
  grim "$@" "$file_path"
  if [ -e "$file_path" ]; then
    notify-send -i "$file_path" "Grim" "Screenshot saved: $file_name"
  fi
}

run_cmd() {
  if [[ "$1" == '--screen' ]]; then
    takeshot
  elif [[ "$1" == '--region' ]]; then
    takeshot "-g" "$(slurp -w 0)"
  else
    takeshot "-g" "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')"
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
$option_screen)
  run_cmd --screen
  ;;
$option_region)
  run_cmd --region
  ;;
$option_window)
  run_cmd --window
  ;;
esac
