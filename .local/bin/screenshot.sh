#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

storage="$HOME/Pictures/Screenshots"
if [[ ! -d "$storage" ]]; then
    mkdir -p "$storage"
fi

prompt='Screenshot'
mesg="Save to $storage"

list_col='1'
list_row='5'
win_width='480px'

option_screen="󰹑 Capture screen"
option_region="󰆞 Capture region"
option_window=" Capture window"

rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
        -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme ${theme}
}

run_rofi() {
    echo -e "$option_screen\n$option_region\n$option_window" | rofi_cmd
}

niri_default_shot() {
    case "$1" in
    '--screen')
        niri msg action screenshot-screen
        ;;
    '--region')
        niri msg action screenshot
        ;;
    '--window')
        niri msg action screenshot-window
        ;;
    esac
}

grim_slurp_shot() {
    time=$(date +%Y-%m-%d_%H-%M-%S)
    file_name="Screenshot_${time}.png"
    file_path="$storage/$file_name"

    sleep 0.15
    case "$1" in
    '--screen')
        grim "$file_path"
        ;;
    '--region')
        grim "-g" "$(slurp -w 0)" "$file_path"
        ;;
    '--window')
        notify-send "Slurp" "Warning: Cannot get window coordinates!"
        exit 1
        ;;
    esac

    if [[ -e "$file_path" ]]; then
        notify-send -i "$file_path" "Grim" "Screenshot saved: $file_name"
    fi
}

run_cmd() {
    if [[ $XDG_CURRENT_DESKTOP == 'niri' ]] && command -v niri msg action >/dev/null; then
        niri_default_shot "$@"
    elif (command -v grim >/dev/null && command -v slurp >/dev/null); then
        grim_slurp_shot "$@"
    else
        notify-send -u "normal" "Warning!" "Missing package(s) to take screenshot: grim/slurp"
        exit 1
    fi
}

flag=$1
if [[ -z "$flag" ]]; then
    chosen="$(run_rofi)"
    case ${chosen} in
    $option_screen)
        flag="--screen"
        ;;
    $option_region)
        flag="--region"
        ;;
    $option_window)
        flag="--window"
        ;;
    esac
fi

run_cmd $flag
