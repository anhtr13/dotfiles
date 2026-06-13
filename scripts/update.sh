#!/usr/bin/env bash
#
# Update any changes in $target/$trackings to $dot

set -e

dot=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
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
    ".doom.d"
)

ignores=()
while IFS= read -r line; do
    ignores+=("$line")
done <"$dot/.gitignore"

###
printf "\n>>> Checking pacman packages...\n"
pacman -Qqne | tee "$dot/installed_packages.txt"
printf "\n----------------------------------------\n" | tee -a "$dot/installed_packages.txt"

###
printf "\n>>> Checking AUR packages...\n"
printf "\n\n\n%s\n%s\n\n" "Package manager: AUR" "--------------------" >>"$dot/installed_packages.txt"
pacman -Qqme | tee -a "$dot/installed_packages.txt"

###
printf "\n>>> Checking Go packages...\n"
printf "\n\n\n%s\n%s\n\n" "Package manager: Go" "--------------------" >>"$dot/installed_packages.txt"
for file in "$GOPATH/bin"/*; do
    if [ -f "$file" ]; then
        info=$(go version -m "$file" | head -n 2)
        printf "%s\n" "${info#$GOPATH/bin/}" | tee -a "$dot/installed_packages.txt"
    fi
done

###
printf "\n>>> Checking Rust packages...\n"
printf "\n\n\n%s\n%s\n\n" "Package manager: Cargo" "--------------------" >>"$dot/installed_packages.txt"
cargo install --list | tee -a "$dot/installed_packages.txt"

###
printf "\n>>> Checking UV packages...\n"
printf "\n\n\n%s\n%s\n\n" "Package manager: UV" "--------------------" >>"$dot/installed_packages.txt"
uv tool list | tee -a "$dot/installed_packages.txt"

###
printf "\n>>> Checking tracking files...\n"
for dir in "${trackings[@]}"; do
    if [ -d "$target/$dir" ]; then
        find "$target/$dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
            file_path=${file#$target/}
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
    fi
done

for dir in "${trackings[@]}"; do
    if [ -d "${dot}/${dir}" ]; then
        find "${dot}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
            dir_suffix=${sub_dir#"$dot/"}
            if [ ! -d "$target/$dir_suffix" ]; then
                rm -rf $sub_dir
                echo "Removed folder: $sub_dir"
            fi
        done
        find "${dot}/${dir}" -type f -print0 | while IFS= read -r -d $'\0' file; do
            file_path=${file#"$dot/"}
            if [ ! -e "$target/$file_path" ]; then
                rm -rf $file
                echo "Removed file: $file"
            fi
        done
    fi
done
