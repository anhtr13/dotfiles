#!/usr/bin/env bash
#
# Update any changes into $dot

set -e

dot=$(dirname $(dirname $(realpath "$0")))
home_configs=(
    ".local/bin"
    ".doom.d"
    ".icons"
    ".config/foot"
    ".config/kitty"
    ".config/niri"
    ".config/nvim"
    ".config/nix"
    ".config/rofi"
    ".config/starship"
    ".config/sway"
    ".config/swaylock"
    ".config/swaync"
    ".config/tmux"
    ".config/vim"
    ".config/waybar"
    ".config/yazi"
    ".config/zsh"
    ".config/mimeapps.list"
    ".profile"
    ".zprofile"
)

ignores=()
while IFS= read -r line; do
    ignores+=("$line")
done <"$dot/.gitignore"

###
printf "\n>>> Checking packages...\n"
cat /var/lib/portage/world | tee "$dot/installed_packages.txt"
printf "\n----------------------------------------\n" | tee -a "$dot/installed_packages.txt"
printf "\n\n\n%s\n%s\n\n" "Package manager: Go" "--------------------" | tee -a "$dot/installed_packages.txt"
for file in "$GOPATH/bin"/*; do
    if [ -f "$file" ]; then
        info=$(go version -m "$file" | head -n 2)
        printf "%s\n" "${info#$GOPATH/bin/}" | tee -a "$dot/installed_packages.txt"
    fi
done
printf "\n\n\n%s\n%s\n\n" "Package manager: Cargo" "--------------------" | tee -a "$dot/installed_packages.txt"
cargo install --list | tee -a "$dot/installed_packages.txt"
printf "\n\n\n%s\n%s\n\n" "Package manager: UV" "--------------------" | tee -a "$dot/installed_packages.txt"
uv tool list | tee -a "$dot/installed_packages.txt"

###
printf "\n>>> Checking home configs...\n"
for item in "${home_configs[@]}"; do
    if [ -d "$HOME/$item" ]; then
        find "$HOME/$item" -type f -print0 | while IFS= read -r -d $'\0' file; do
            suffix=${file#$HOME/}
            flag=true
            for ign in ${ignores[@]}; do
                if [[ $suffix == *$ign* ]]; then
                    flag=false
                    break
                fi
            done
            if $flag; then
                echo $suffix
                dir=${dot}/$(dirname $suffix)
                mkdir -p $dir
                cp -p $file $dir
            fi
        done
    elif [ -f "$HOME/$item" ]; then
        echo $item
        dir=${dot}/$(dirname $item)
        mkdir -p $dir
        cp -p $HOME/$item $dir
    fi
done

for item in "${home_configs[@]}"; do
    if [ -d "${dot}/${item}" ]; then
        find "${dot}/${item}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' dir; do
            suffix=${dir#"$dot/"}
            if [ ! -d "$HOME/$suffix" ]; then
                rm -rf $dir
                echo "Removed directory: $dir"
            fi
        done
        find "${dot}/${item}" -type f -print0 | while IFS= read -r -d $'\0' file; do
            suffix=${file#"$dot/"}
            if [ ! -f "$HOME/$suffix" ]; then
                rm $file
                echo "Removed file: $file"
            fi
        done
    elif [ -f "$dot/$item" ]; then
        if [ ! -f "$HOME/$item" ]; then
            rm "$dot/$item"
            echo "Removed file: $item"
        fi
    fi
done

###
printf "\n>>> Checking portage configs...\n"
mkdir -p "$dot/portage/"
for item in /etc/portage/*; do
    if [[ $(basename $item) != "gnupg" ]]; then
        if [ -f $item ]; then
            echo $item
            cp -p $item "$dot/portage/"
        elif [ -d $item ]; then
            find $item -type f -print0 | while IFS= read -r -d $'\0' file; do
                echo $file
                suffix=${file#/etc/}
                dir=${dot}/$(dirname $suffix)
                mkdir -p $dir
                cp -p $file $dir
            done
        fi
    fi
done

for item in $dot/portage/*; do
    if [ -f "$item" ]; then
        suffix=${item#"$dot/"}
        if [ ! -f "/etc/$suffix" ]; then
            rm "$item"
            echo "Removed file: $item"
        fi
    elif [ -d "$item" ]; then
        find "$item" -type f -print0 | while IFS= read -r -d $'\0' file; do
            suffix=${file#"$dot/"}
            if [ ! -f "/etc/$suffix" ]; then
                rm "$file"
                echo "Removed file: $file"
            fi
        done
        find "$item" -type d -print0 | while IFS= read -r -d $'\0' dir; do
            suffix=${dir#"$dot/"}
            if [ ! -d "/etc/$suffix" ] || [ -z "$(ls -A $dir)" ]; then
                rm -rf "$dir"
                echo "Removed directory: $dir"
            fi
        done
    fi
done
