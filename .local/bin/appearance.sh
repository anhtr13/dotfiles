#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Appearance'
mesg="# Appearance setting."

list_col='1'
list_row='5'

option_wallpaper="󰸉 Wallpaper"
option_bar_style="󰘤 Bar style"
option_transparent="󰀿 Background transparent"
option_non_transparent="󰀿 Background non-transparent"

cmd_wallpaper='wallpaper.sh'
cmd_bar_style='waybar_theme.sh'
cmd_transparent() {
    sed -i 's/    opacity .*/    opacity 0.8/' $XDG_CONFIG_HOME/niri/config.kdl
}
cmd_non_transparent() {
    sed -i 's/    opacity .*/    opacity 1.0/' $XDG_CONFIG_HOME/niri/config.kdl
}

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
    echo -e "$option_wallpaper\n$option_bar_style\n$option_transparent\n$option_non_transparent" | rofi_cmd
}

chosen="$(run_rofi)"
case "$chosen" in
$option_wallpaper)
    ${cmd_wallpaper}
    ;;
$option_bar_style)
    ${cmd_bar_style}
    ;;
$option_transparent)
    cmd_transparent
    ;;
$option_non_transparent)
    cmd_non_transparent
    ;;
esac
