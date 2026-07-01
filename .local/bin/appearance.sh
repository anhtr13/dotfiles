#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Appearance'
mesg="# Appearance setting."

list_col='1'
list_row='5'

option_wallpaper="󰸉 Wallpaper"
option_bar_style="󰘤 Bar style"
option_enable_transparent="󰀿 Enable transparent"
option_disable_transparent="󰀿 Disable transparent"

cmd_wallpaper='wallpaper.sh'
cmd_bar_style='waybar_theme.sh'
enable_transparent() {
    sed -i 's/    opacity .*/    opacity 0.8/' $XDG_CONFIG_HOME/niri/config.kdl
    sed -i 's/@define-color base.*/@define-color base   rgba(0, 0, 0, 0.8);/' $XDG_CONFIG_HOME/waybar/colors.css
    wb_style=$(cat $XDG_CONFIG_HOME/waybar/style.css)
    echo $wb_style >$XDG_CONFIG_HOME/waybar/style.css
}
disable_transparent() {
    sed -i 's/    opacity .*/    opacity 1.0/' $XDG_CONFIG_HOME/niri/config.kdl
    sed -i 's/@define-color base.*/@define-color base   rgba(0, 0, 0, 1);/' $XDG_CONFIG_HOME/waybar/colors.css
    wb_style=$(cat $XDG_CONFIG_HOME/waybar/style.css)
    echo $wb_style >$XDG_CONFIG_HOME/waybar/style.css
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
    if [[ $XDG_CURRENT_DESKTOP = "niri" ]]; then
        echo -e "$option_wallpaper\n$option_bar_style\n$option_enable_transparent\n$option_disable_transparent" | rofi_cmd
    else
        echo -e "$option_wallpaper\n$option_bar_style" | rofi_cmd
    fi
}

chosen="$(run_rofi)"
case "$chosen" in
$option_wallpaper)
    ${cmd_wallpaper}
    ;;
$option_bar_style)
    ${cmd_bar_style}
    ;;
$option_enable_transparent)
    enable_transparent
    ;;
$option_disable_transparent)
    disable_transparent
    ;;
esac
