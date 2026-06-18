#!/usr/bin/env bash
#
# Update any changes into $dot

set -e

dot=$(dirname $(dirname $(realpath "$0")))
home_configs=(
    ".local/bin"
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
    ".doom.d"
    ".icons"
)

ignores=()
while IFS= read -r line; do
    ignores+=("$line")
done <"$dot/.gitignore"

###
printf "\n>>> Checking packages...\n"
cat /var/lib/portage/world | tee "$dot/installed_packages.txt"
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
for dir in "${home_configs[@]}"; do
    if [ -d "$HOME/$dir" ]; then
        find "$HOME/$dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
            file_path=${file#$HOME/}
            flag=true
            for ign in ${ignores[@]}; do
                if [[ $file_path == *$ign* ]]; then
                    flag=false
                    break
                fi
            done
            if $flag; then
                echo "$file_path"
                file_dir=$(dirname $file_path)
                mkdir -p "$dot/$file_dir"
                cp -p $file "$dot/$file_dir"
            fi
        done
    elif [ -f "$HOME/$dir" ]; then
        file_path=$dir
        echo "$file_path"
        file_dir=$(dirname $file_path)
        mkdir -p "$dot/$file_dir"
        cp -p "$HOME/$file_path" "$dot/$file_dir"
    fi
done

for dir in "${home_configs[@]}"; do
    if [ -d "${dot}/${dir}" ]; then
        find "${dot}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
            dir_suffix=${sub_dir#"$dot/"}
            if [ ! -d "$HOME/$dir_suffix" ]; then
                rm -rf $sub_dir
                echo "Removed folder: $sub_dir"
            fi
        done
        find "${dot}/${dir}" -type f -print0 | while IFS= read -r -d $'\0' file; do
            file_path=${file#"$dot/"}
            if [ ! -e "$HOME/$file_path" ]; then
                rm -rf $file
                echo "Removed file: $file"
            fi
        done
    elif [ -f "$dot/$dir" ]; then
        file_path=$dir
        if [ ! -f "$HOME/$file_path" ]; then
            rm -rf "$HOME/$file_path"
            echo "Removed file: $file_path"
        fi
    fi
done

###
printf "\n>>> Checking portage configs...\n"
find "/etc/portage" -type f -print0 | while IFS= read -r -d $'\0' file; do
    file_path=${file#/etc/}
    flag=true
    for ign in ${ignores[@]}; do
        if [[ $file_path == *$ign* ]]; then
            flag=false
            break
        fi
    done
    if $flag; then
        echo "$file_path"
        file_dir=$(dirname $file_path)
        mkdir -p "$dot/$file_dir"
        cp -p $file "$dot/$file_dir"
    fi
done
