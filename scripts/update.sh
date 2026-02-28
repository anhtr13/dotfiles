#!/usr/bin/env bash
#
# Update any changes in $target/$trackings to $dotdir
#

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
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
done <"$dotdir/.gitignore"

pacman -Qqne >"$dotdir/installed_packages.txt"

printf "\n%s\n%s\n" "----- START -----" "# Packages installed via AUR:" >>"$dotdir/installed_packages.txt"
pacman -Qqme >>"$dotdir/installed_packages.txt"
printf "%s\n\n" "----- END -----" >>"$dotdir/installed_packages.txt"

printf "\n%s\n%s\n" "----- START -----" "# Packages installed via Cargo:" >>"$dotdir/installed_packages.txt"
cargo install --list >>"$dotdir/installed_packages.txt"
printf "%s\n\n" "----- END -----" >>"$dotdir/installed_packages.txt"

for dir in "${trackings[@]}"; do
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
            if [[ -e "$dotdir/$file_suffix" ]]; then
                cp $file "$dotdir/$file_suffix"
            else
                install -Dv $file "$dotdir/$file_suffix"
            fi
        fi
    done
done

for dir in "${trackings[@]}"; do
    find "${dotdir}/${dir}" -mindepth 1 -type d -print0 | while IFS= read -r -d $'\0' sub_dir; do
        dir_suffix=${sub_dir#"$dotdir/"}
        if ! [[ -d "$target/$dir_suffix" ]]; then
            rm -rf $sub_dir
            echo "Removed folder: $sub_dir"
        fi
    done
    find "${dotdir}/${dir}" -type f -print0 | while IFS= read -r -d $'\0' file; do
        file_suffix=${file#"$dotdir/"}
        if ! [[ -e "$target/$file_suffix" ]]; then
            rm -rf $file
            echo "Removed file: $file"
        fi
    done
done
