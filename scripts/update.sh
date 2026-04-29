#!/usr/bin/env bash
#
# Update any changes in $target/$trackings to $dotdir

set -e

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
    ".local/bin"
    ".config/foot"
    ".config/kitty"
    ".config/niri"
    ".config/nvim"
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
done <"$dotdir/.gitignore"

###
printf "==> Checking pacman packages...\n"
pacman -Qqne | tee "$dotdir/installed_packages.txt"

###
printf "\n==> Checking AUR packages...\n"
printf "\n\n%s\n%s\n\n" "-----BEGIN BLOCK-----" "Package manager: AUR" >>"$dotdir/installed_packages.txt"
pacman -Qqme | tee -a "$dotdir/installed_packages.txt"
printf "%s\n\n" "-----END BLOCK-----" >>"$dotdir/installed_packages.txt"

###
printf "\n==> Checking Go packages...\n"
printf "\n%s\n%s\n\n" "-----BEGIN BLOCK-----" "Package manager: Go" >>"$dotdir/installed_packages.txt"
for file in "$GOPATH/bin"/*; do
    if [ -f "$file" ]; then
        info=$(go version -m "$file" | head -n 2)
        printf "%s\n" "${info#$GOPATH/bin/}" | tee -a "$dotdir/installed_packages.txt"
    fi
done
printf "%s\n\n" "-----END BLOCK-----" >>"$dotdir/installed_packages.txt"

###
printf "\n==> Checking Rust packages...\n"
printf "\n%s\n%s\n\n" "-----BEGIN BLOCK-----" "Package manager: Cargo" >>"$dotdir/installed_packages.txt"
cargo install --list | tee -a "$dotdir/installed_packages.txt"
printf "%s\n\n" "-----END BLOCK-----" >>"$dotdir/installed_packages.txt"

###
printf "\n==> Checking UV packages...\n"
printf "\n%s\n%s\n\n" "-----BEGIN BLOCK-----" "Package manager: UV" >>"$dotdir/installed_packages.txt"
uv tool list | tee -a "$dotdir/installed_packages.txt"
printf "%s\n\n" "-----END BLOCK-----" >>"$dotdir/installed_packages.txt"

###
printf "\n==> Checking tracking files...\n"
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
            echo "$file"
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
