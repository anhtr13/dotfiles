#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Setting'
mesg="# General setting."

list_col='1'
list_row='6'

cmd_wallpaper='wallpaper.sh'
cmd_waybar='waybar.sh'
cmd_network='footclient sh -c nmtui'

option_wallpaper="󰸉 Wallpaper"
option_waybar=" Waybar"
option_network="󱂇 Network"

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
    echo -e "$option_wallpaper\n$option_waybar\n$option_network" | rofi_cmd
}

chosen="$(run_rofi)"
case "$chosen" in
$option_wallpaper)
    ${cmd_wallpaper}
    ;;
$option_waybar)
    ${cmd_waybar}
    ;;
$option_network)
    ${cmd_network}
    ;;
esac
