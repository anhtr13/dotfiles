#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Setting'
mesg="# General setting."

list_col='1'
list_row='6'

option_appearance="󰸌 Appearance"
option_network="󰀂 Network Manager"

cmd_appearance='appearance.sh'
cmd_network='footclient sh -c nmtui'

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
    echo -e "$option_appearance\n$option_network" | rofi_cmd
}

chosen="$(run_rofi)"
case "$chosen" in
$option_appearance)
    ${cmd_appearance}
    ;;
$option_network)
    ${cmd_network}
    ;;
esac
