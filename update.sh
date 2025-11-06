#!/bin/bash

pacman -Qqe >installed_packages.txt

here=$(dirname "$(realpath "$0")")
dirs=(".config" ".local")
ignores=()

while IFS= read -r line; do
  ignores+=("$line")
done <"$here/.gitignore"

for dir in "${dirs[@]}"; do
  find "${here}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
    sub_dir_suffix=${sub_dir#"$here/"}
    find "$HOME/$sub_dir_suffix" -type f -print0 | while IFS= read -r -d $'\0' file; do
      file_suffix=${file#$HOME/}
      flag=true
      for ign in ${ignores[@]}; do
        if [[ $file_suffix == *$ign* ]]; then
          flag=false
          break
        fi
      done
      if $flag; then
        if [[ -e "$here/$file_suffix" ]]; then
          cp $file "$here/$file_suffix"
        else
          install -Dv $file "$here/$file_suffix"
        fi
      fi
    done
  done
done

for dir in "${dirs[@]}"; do
  find "${here}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
    sub_dir_suffix=${sub_dir#"$here/"}
    if ! [[ -d "$HOME/$sub_dir_suffix" ]]; then
      rm -rf $sub_dir
      echo "Removed folder: $sub_dir"
    fi
  done
  find "${here}/${dir}" -type f -print0 | while IFS= read -r -d $'\0' file; do
    file_suffix=${file#$here/}
    if ! [[ -e "$HOME/$file_suffix" ]]; then
      rm -rf $file
      echo "Removed file: $file"
    fi
  done
done
