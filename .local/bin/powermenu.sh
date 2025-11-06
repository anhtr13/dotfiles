#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt="Powermenu"
mesg="# Uptime: $(uptime -p | sed -e 's/up //g')"

list_col='1'
list_row='6'

option_lock=" Lock"
option_logout=" Logout"
option_suspend=" Suspend"
option_reboot=" Reboot"
option_shutdown=" Shutdown"
yes='✓ Yes'
no='✗ No'

rofi_cmd() {
  rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: "";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
}

run_rofi() {
  echo -e "$option_lock\n$option_logout\n$option_suspend\n$option_reboot\n$option_shutdown" | rofi_cmd
}

confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme ${theme}
}

confirm_exit() {
  echo -e "$no\n$yes" | confirm_cmd
}

confirm_run() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    ${1} && ${2}
  else
    exit
  fi
}

chosen="$(run_rofi)"
case ${chosen} in
$option_lock)
  hyprlock
  ;;
$option_logout)
  confirm_run 'kill -9 -1'
  ;;
$option_suspend)
  confirm_run 'amixer set Master mute' 'systemctl suspend'
  ;;
$option_reboot)
  confirm_run 'systemctl reboot'
  ;;
$option_shutdown)
  confirm_run 'systemctl poweroff'
  ;;
esac
