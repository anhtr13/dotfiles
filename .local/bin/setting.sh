#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Setting'
mesg="# General setting."

list_col='1'
list_row='6'

cmd_wallpaper='wallpaper.sh'
cmd_waybar='waybar.sh'

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

chosen="$(run_rofi)"
case "$chosen" in
$option_wallpaper)
    ${cmd_wallpaper}
    ;;
$option_waybar)
    ${cmd_waybar}
    ;;
esac
