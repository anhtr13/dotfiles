#!/usr/bin/env bash
#
# Setup configs and install base packages

set -e

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
    ".config"
    ".local"
    ".doom.d"
    ".icons"
    ".profile"
    ".zprofile"
)

###
printf "\n>>> Copying config files...\n"
for dir in "${trackings[@]}"; do
    cp -r "$dotdir/$dir" "$target"
done
echo "Done."

###
if command -v emerge &>/dev/null; then
    pkgs=()
    while IFS= read -r line; do
        if [[ "$line" =~ ^"----------" ]]; then
            break
        fi
        pkgs+=($line)
    done <"$dotdir/installed_packages.txt"

    sudo emerge --sync

    if [ ${#pkgs[@]} -gt 0 ]; then
        printf "\n>>> Installing core packages...\n"
        sudo emerge --ask --noreplace "${pkgs[@]}"
    fi
fi

###
if $(command -v zsh &>/dev/null); then
    read -p $'\n>>> Setup Zshell? [y/n]: ' chosen
    if [ $chosen == "y" ] || [ $chosen == "Y" ]; then
        printf ">>> Installing plugin...\n"
        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-autosuggestions" ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.local/share/zsh/plugins/zsh-autosuggestions"
        fi
        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-history-substring-search" ]; then
            git clone https://github.com/zsh-users/zsh-history-substring-search "$HOME/.local/share/zsh/plugins/zsh-history-substring-search"
        fi
        if [ ! -e "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting" ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.local/share/zsh/plugins/zsh-syntax-highlighting"
        fi

        printf ">>> Change shell to Zsh...\n"
        shell=$(basename $SHELL)
        if [ "$shell" != "zsh" ]; then
            chsh -s "$(which zsh)"
        fi
    fi
fi
