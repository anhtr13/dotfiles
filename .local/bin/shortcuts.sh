#!/usr/bin/env bash

theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"

prompt='Shortcuts'
mesg="# Pacman: $(pacman -Q | wc -l) packages installed."

list_col='1'
list_row='6'

cmd_term='footclient'
cmd_browser='brave'
cmd_file='footclient sh -c yazi'
cmd_pdf='zathura'
cmd_music='footclient sh -c kew'
cmd_setting='setting.sh'

option_term=" Terminal <span weight='light' size='small'><i>($cmd_term)</i></span>"
option_browser=" Browser <span weight='light' size='small'><i>($cmd_browser)</i></span>"
option_file=" Files <span weight='light' size='small'><i>($cmd_file)</i></span>"
option_pdf=" Read <span weight='light' size='small'><i>($cmd_pdf)</i></span>"
option_music=" Music <span weight='light' size='small'><i>($cmd_music)</i></span>"
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
    echo -e "$option_term\n$option_browser\n$option_file\n$option_pdf\n$option_music\n$option_setting" | rofi_cmd
}

chosen="$(run_rofi)"
case "$chosen" in
$option_term)
    ${cmd_term}
    ;;
$option_browser)
    ${cmd_browser}
    ;;
$option_pdf)
    ${cmd_pdf}
    ;;
$option_file)
    ${cmd_file}
    ;;
$option_music)
    ${cmd_music}
    ;;
$option_setting)
    ${cmd_setting}
    ;;
esac
