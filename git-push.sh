#!/bin/bash

message="$1"
if [[ -z "$message" ]]; then
  message="Update #$(git rev-list --count HEAD)"
fi

git add -A

rofi_theme="$XDG_CONFIG_HOME/rofi/themes/applet.rasi"
yes='✓ Yes'
no='✗ No'

confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
    -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg "Push '${message}'?" \
    -theme ${rofi_theme}
}

selected=$(echo -e "$no\n$yes" | confirm_cmd)
if [[ "$selected" == "$yes" ]]; then
  git commit -m "$message"

  eval $(keychain --eval id_ed25519)

  echo "Pushing '$message'..."

  git push github main &
  PIDS[0]=$!
  git push codeberg main &
  PIDS[1]=$!

  failed_count=0
  for pid in "${PIDS[@]}"; do
    wait "$pid" || ((++failed_count))
  done

  if ((failed_count > 0)); then
    echo "Warning: $failed_count background processes failed."
  else
    echo "All push are complete."
  fi
else
  exit
fi
