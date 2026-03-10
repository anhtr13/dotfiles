#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Screenshot'
mesg="DIR: $HOME/Desktop/Pictures/Screenshots"

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

time=$(date +%Y-%m-%d-%H-%M-%S)
dir="$HOME/Pictures/Screenshots"
file_name="Screenshot_${time}.png"
file_path="$dir/$file_name"

if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
fi

shot_via_grim() {
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

shot_via_hyprshot() {
    case "$1" in
    '--screen')
        hyprshot -m output -f $file_name -o $dir
        ;;
    '--region')
        hyprshot -m region -f $file_name -o $dir
        ;;
    '--window')
        hyprshot -m window -f $file_name -o $dir
        ;;
    esac
}

run_cmd() {
    if [[ $XDG_CURRENT_DESKTOP == 'Hyprland' ]] && command -v hyprshot >/dev/null; then
        shot_via_hyprshot "$@"
    elif (command -v grim >/dev/null && command -v slurp >/dev/null); then
        shot_via_grim "$@"
    else
        notify-send -u "normal" "Warning!" "Missing package(s) to take screenshot: grim/slurp"
        exit 1
    fi
}

chosen="$(run_rofi)"
case ${chosen} in
$option_screen)
    run_cmd --screen
    ;;
$option_region)
    run_cmd --region
    ;;
$option_window)
    run_cmd --window
    ;;
esac
