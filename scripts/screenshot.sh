#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Screenshot'
mesg="DIR: $(xdg-user-dir PICTURES)/Screenshots"

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
dir="$(xdg-user-dir PICTURES)/Screenshots"
file_name="Screenshot_${time}.png"

if [[ ! -d "$dir" ]]; then
  mkdir -p "$dir"
fi

takeshot() {
  hyprshot -m ${1} -f "$file_name" -o "$dir"
}

run_cmd() {
  if [[ "$1" == '--screen' ]]; then
    takeshot output
  elif [[ "$1" == '--window' ]]; then
    takeshot window
  elif [[ "$1" == '--region' ]]; then
    takeshot region
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
