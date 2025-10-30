#!/bin/bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Shortcuts'
mesg="# Pacman: $(pacman -Q | wc -l) packages installed."

list_col='1'
list_row='8'

cmd_term='ghostty'
cmd_web='brave'
cmd_file='kitty sh -c yazi'
cmd_text='kitty sh -c nvim'
cmd_vpn='protonvpn-app'
cmd_player='kitty sh -c kew'
cmd_setting='sh ~/.config/scripts/setting.sh'

option_term=" Terminal <span weight='light' size='small'><i>($cmd_term)</i></span>"
option_web=" Browser <span weight='light' size='small'><i>($cmd_web)</i></span>"
option_file=" Files <span weight='light' size='small'><i>($cmd_file)</i></span>"
option_editor=" Editor <span weight='light' size='small'><i>($cmd_text)</i></span>"
option_vpn="󰖂 VPN <span weight='light' size='small'><i>($cmd_vpn)</i></span>"
option_player=" Music <span weight='light' size='small'><i>($cmd_player)</i></span>"
option_setting=" Setting <span weight='light' size='small'><i>(Ctrl + 󰘳 + O)</i></span>"

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
  echo -e "$option_term\n$option_web\n$option_vpn\n$option_file\n$option_editor\n$option_player\n$option_setting" | rofi_cmd
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
  "--vpn")
    ${cmd_vpn}
    ;;
  "--player")
    ${cmd_player}
    ;;
  "--setting")
    eval ${cmd_setting}
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
$option_editor)
  run_cmd --text
  ;;
$option_file)
  run_cmd --file
  ;;
$option_vpn)
  run_cmd --vpn
  ;;
$option_player)
  run_cmd --player
  ;;
$option_setting)
  run_cmd --setting
  ;;
esac
