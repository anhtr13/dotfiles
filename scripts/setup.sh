#!/usr/bin/env bash
#
# Basic setup after installation

set -e

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
    ".config"
    ".local"
    ".doom.d"
)

###
printf "\n>>> Copying config files...\n"
for dir in "${trackings[@]}"; do
    cp -r "$dotdir/$dir" "$target"
done
echo "Done."

###
if command -v pacman &>/dev/null; then
    pkgs=()
    while IFS= read -r line; do
        if [[ "$line" == "----------*" ]]; then
            break
        fi
    done <"$dotdir/installed_packages.txt"

    sudo pacman -Syu --needed base-devel git

    pkgs_to_install=($(comm -12 <(pacman -Slq | sort -u) <(printf '%s\n' "${pkgs[@]}" | sort -u)))
    if [ ${#pkgs_to_install[@]} -gt 0 ]; then
        printf "\n>>> Installing core packages...\n"
        sudo pacman -S --needed "${pkgs_to_install[@]}"
    fi

    pkgs_not_found=($(comm -23 <(printf '%s\n' "${pkgs[@]}" | sort -u) <(printf '%s\n' "${pkgs_to_install[@]}" | sort -u)))
    if [ ${#pkgs_not_found[@]} -gt 0 ]; then
        printf "\n>>> Packages not found and ignored:\n"
        printf "%s\n" "${pkgs_not_found[@]}"
    fi

    ###
    read -p $'\n>>> Setup AUR? [y/n]: ' chosen
    if [ "$chosen" == "y" ]; then
        printf ">>> Setting up AUR..."
        if ! $(pacman -Q yay >/dev/null); then
            git clone https://aur.archlinux.org/yay-bin.git $target/yay
            cd $target/yay
            makepkg -si
            cd $dotdir
            rm -rf $target/yay
        else
            echo "AUR has already installed."
        fi
    fi
fi

###
if $(command -v zsh &>/dev/null); then
    read -p $'\n>>> Setup Zshell? [y/n]: ' chosen
    if [ "$chosen" == "y" ]; then
        printf ">>> Setting up Zsh...\n"

        if [ ! -f /etc/zsh/zshenv ]; then
            sudo mkdir -p /etc/zsh && sudo touch /etc/zsh/zshenv
        fi
        cat "$dotdir/.config/zsh/etc-zsh-zshenv" | sudo tee /etc/zsh/zshenv

        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
        fi
        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-history-substring-search" ]; then
            git clone https://github.com/zsh-users/zsh-history-substring-search "$HOME/.local/share/zsh/plugins/zsh-history-substring-search"
        fi
        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting" ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting"
        fi

        shell=$(basename $SHELL)
        if [ "$shell" != "zsh" ]; then
            chsh -s "/usr/bin/zsh"
        fi
    fi
fi
