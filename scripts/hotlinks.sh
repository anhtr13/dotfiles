#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Hot Links'
mesg="# Using Brave as web browser"

list_col='1'
list_row='6'

option_github=" Github"
option_reddit=" Reddit"
option_gmail=" Gmail"
option_youtube=" Youtube"
option_translate="󰊿 Translate"

rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  echo -e "$option_github\n$option_reddit\n$option_gmail\n$option_youtube\n$option_translate" | rofi_cmd
}

run_cmd() {
  if [[ "$1" == '--github' ]]; then
    xdg-open 'https://www.github.com/'
  elif [[ "$1" == '--reddit' ]]; then
    xdg-open 'https://www.reddit.com/'
  elif [[ "$1" == '--gmail' ]]; then
		xdg-open 'https://mail.google.com/'
  elif [[ "$1" == '--youtube' ]]; then
    xdg-open 'https://www.youtube.com/'
  elif [[ "$1" == '--translate' ]]; then
    xdg-open 'https://translate.google.com/?sl=en&tl=vi&op=translate'
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
$option_gmail)
  run_cmd --gmail
  ;;
$option_youtube)
  run_cmd --youtube
  ;;
$option_github)
  run_cmd --github
  ;;
$option_reddit)
  run_cmd --reddit
  ;;
$option_translate)
  run_cmd --translate
  ;;
esac
