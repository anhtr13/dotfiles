#!/bin/bash

source_dir=~/.config

ignores=()
while IFS= read -r line; do
  ignores+=("$line")
done <.gitignore

for cur_folder in */; do
  source_folder="$source_dir/$cur_folder"
  find $source_folder -type f -print0 | while IFS= read -r -d $'\0' source_file; do
    path=${source_file#$source_dir}

    flag=true
    for ign in ${ignores[@]}; do
      if [[ $path == $ign* ]]; then
        flag=false
        break
      fi
    done

    if $flag; then
      dest_file=${path#/}
      if ! [[ -e $dest_file ]]; then
        install -Dv $source_file $dest_file
      else
        cp $source_file $dest_file
      fi
    fi
  done
done

for folder in */; do
  if [[ $folder != ".git" ]]; then

    find $folder -type d -print0 | while IFS= read -r -d $'\0' cur_folder; do
      source_folder="$source_dir/$cur_folder"
      cur_folder="./$cur_folder"
      if ! [[ -d $source_folder ]]; then
        rm -rf $cur_folder
        echo "Removed folder: $cur_folder"
      fi
    done

    find $folder -type f -print0 | while IFS= read -r -d $'\0' cur_file; do
      source_file="$source_dir/$cur_file"
      cur_file="./$cur_file"
      if ! [[ -e $source_file ]]; then
        rm -rf $cur_file
        echo "Removed file: $cur_file"
      fi
    done

  fi
done

git add -A
git commit -m "update"
git push origin main
