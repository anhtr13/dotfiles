#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Hot Links'
mesg="# Using Brave as web browser"

list_col='1'
list_row='6'

option_github=" Github"
option_reddit=" Reddit"
option_email=" Email"
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
  echo -e "$option_github\n$option_reddit\n$option_email\n$option_youtube\n$option_translate" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
$option_email)
  xdg-open 'https://mail.google.com/'
  ;;
$option_youtube)
  xdg-open 'https://www.youtube.com/'
  ;;
$option_github)
  xdg-open 'https://www.github.com/'
  ;;
$option_reddit)
  xdg-open 'https://www.reddit.com/'
  ;;
$option_translate)
  xdg-open 'https://translate.google.com/?sl=en&tl=vi&op=translate'
  ;;
esac
