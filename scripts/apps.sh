#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Applications'
mesg="# Pacman: $(pacman -Q | wc -l) packages installed."

list_col='1'
list_row='6'

cmd_term='ghostty'
cmd_web='brave'
cmd_file='nautilus'
cmd_text='gnome-text-editor'
cmd_music='ghostty -e ncmpcpp'

option_term=" Terminal <span weight='light' size='small'><i>($cmd_term)</i></span>"
option_web=" Browser <span weight='light' size='small'><i>($cmd_web)</i></span>"
option_file=" Files <span weight='light' size='small'><i>($cmd_file)</i></span>"
option_text=" Editor <span weight='light' size='small'><i>($cmd_text)</i></span>"
option_music="󰝚 Music <span weight='light' size='small'><i>($cmd_music)</i></span>"

rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  echo -e "$option_term\n$option_web\n$option_file\n$option_text\n$option_music" | rofi_cmd
}

run_cmd() {
  case $1 in
  "--term")
    ${cmd_term}
    ;;
  "--web")
    ${cmd_web}
    ;;
  "--text")
    ${cmd_text}
    ;;
  "--file")
    ${cmd_file}
    ;;
  "--music")
    ${cmd_music}
    ;;
  esac
}

chosen="$(run_rofi)"
case "$chosen" in
$option_term)
  run_cmd --term
  ;;
$option_web)
  run_cmd --web
  ;;
$option_text)
  run_cmd --text
  ;;
$option_file)
  run_cmd --file
  ;;
$option_music)
  run_cmd --music
  ;;
esac
