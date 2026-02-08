#!/bin/bash
#
# Tracking any changes in $target/$track_dirs and update them in $here/$track_dirs
#

target=$HOME
here=$(dirname "$(realpath "$0")")
track_dirs=(
    ".local/bin"
    ".config/fastfetch"
    ".config/foot"
    ".config/ghostty"
    ".config/hypr"
    ".config/kitty"
    ".config/niri"
    ".config/nvim"
    ".config/nvim_lite"
    ".config/rofi"
    ".config/starship"
    ".config/sway"
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
done <"$here/.gitignore"

pacman -Qqne >"$here/installed_packages.txt"

printf "\n%s\n%s\n" "----- START -----" "# Packages installed via AUR:" >>"$here/installed_packages.txt"
pacman -Qqme >>"$here/installed_packages.txt"
printf "%s\n\n" "----- END -----" >>"$here/installed_packages.txt"

printf "\n%s\n%s\n" "----- START -----" "# Packages installed via cargo:" >>"$here/installed_packages.txt"
cargo install --list >>"$here/installed_packages.txt"
printf "%s\n\n" "----- END -----" >>"$here/installed_packages.txt"

for dir in "${track_dirs[@]}"; do
    find "$target/$dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
        file_suffix=${file#$target/}
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

for dir in "${track_dirs[@]}"; do
    find "${here}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
        dir_suffix=${sub_dir#"$here/"}
        if ! [[ -d "$target/$dir_suffix" ]]; then
            rm -rf $sub_dir
            echo "Removed folder: $sub_dir"
        fi
    done
    find "${here}/${dir}" -type f -print0 | while IFS= read -r -d $'\0' file; do
        file_suffix=${file#"$here/"}
        if ! [[ -e "$target/$file_suffix" ]]; then
            rm -rf $file
            echo "Removed file: $file"
        fi
    done
done
