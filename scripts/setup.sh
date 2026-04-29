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
printf "\n==> PREPARING...\n"
sudo pacman -Syu --needed base-devel git

###
printf "\n==> COPYING CONFIG FILES...\n"
for dir in "${trackings[@]}"; do
    cp -r "$dotdir/$dir" "$target"
done
echo "Done."

###
printf "\n==> SETTING UP AUR...\n"
if ! $(pacman -Q yay >/dev/null); then
    git clone https://aur.archlinux.org/yay-bin.git $target/yay
    cd $target/yay
    makepkg -si
    cd $dotdir
    rm -rf $target/yay
else
    echo "AUR has already installed."
fi

###
printf "\n==> INSTALLING CORE PACKAGES...\n"

pkgs=()
ignore=false

while IFS= read -r line; do
    if [[ "$line" == "-----BEGIN BLOCK-----" ]]; then
        ignore=true
        continue
    elif [[ "$line" == "-----END BLOCK-----" ]]; then
        ignore=false
        continue
    fi

    if ! $ignore && [[ -n "$line" ]]; then
        pkgs+=("$line")
    fi
done <"$dotdir/installed_packages.txt"

pkgs_to_install=($(comm -12 <(pacman -Slq | sort -u) <(printf '%s\n' "${pkgs[@]}" | sort -u)))
sudo pacman -S --needed "${pkgs_to_install[@]}"

pkgs_not_found=($(comm -23 <(printf '%s\n' "${pkgs[@]}" | sort -u) <(printf '%s\n' "${pkgs_to_install[@]}" | sort -u)))
printf "\\n--------------------- Packages not found and ignored: ---------------------\\n"
printf "%s\\n" "${pkgs_not_found[@]}"

###
printf "\n==> SETTING UP ZSH...\n"

# System-wide zshenv
if ! [[ -f /etc/zsh/zshenv ]]; then
    sudo mkdir -p /etc/zsh && sudo touch /etc/zsh/zshenv
fi
cat "$dotdir/.config/zsh/etc-zsh-zshenv" | sudo tee /etc/zsh/zshenv

# Zsh plugins
if ! [[ -e "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
fi
if ! [[ -e "$HOME/.local/share/zsh/plugins/zsh-history-substring-search" ]]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search "$HOME/.local/share/zsh/plugins/zsh-history-substring-search"
fi
if ! [[ -e "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting"
fi

# Change shell
shell=$(basename $SHELL)
if [[ "$shell" != "zsh" ]]; then
    chsh -s "/usr/bin/zsh"
fi
