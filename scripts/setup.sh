#!/usr/bin/env bash
#
# Basic setup after installation

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME
trackings=(
    ".config"
    ".local"
    ".doom.d"
)

#
# ===============================================================================================
printf "\n==================== Preparing the necessary packages... ====================\n"
sudo pacman -Syu --needed base-devel git

#
# ===============================================================================================
printf "\n==================== Copying config files... ====================\n"
for dir in "${trackings[@]}"; do
    cp -r "$dotdir/$dir" "$target"
done

#
# ===============================================================================================
printf "\n==================== Setting up AUR... ====================\n"
if ! $(pacman -Q yay >/dev/null); then
    git clone https://aur.archlinux.org/yay-bin.git $target/yay
    cd $target/yay
    makepkg -si
    cd $dotdir
    rm -rf $target/yay
else
    echo "AUR has already installed."
fi

#
# ===============================================================================================
printf "\n==================== Installing core packages... ====================\n"

pkgs=()
ignore=false

while IFS= read -r line; do
    if [[ "$line" == "----- START -----" ]]; then
        ignore=true
        continue
    elif [[ "$line" == "----- END -----" ]]; then
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
printf "\\n--------------------------------------------------\\nPackages not found and ignored:\\n\\n"
printf "%s\\n" "${pkgs_not_found[@]}"

#
# ===============================================================================================
printf "\n==================== Setting up Zsh... ====================\n"

# System-wide zshenv
if ! [[ -f /etc/zsh/zshenv ]]; then
    sudo mkdir -p /etc/zsh && sudo touch /etc/zsh/zshenv
fi
cat "$dotdir/.config/zsh/etc-zsh-zshenv" | sudo tee /etc/zsh/zshenv

# Zsh plugins
if ! [[ -e "/usr/share/zsh/plugins/zsh-autosuggestions" ]]; then
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions
fi
if ! [[ -e "/usr/share/zsh/plugins/zsh-history-substring-search" ]]; then
    sudo git clone https://github.com/zsh-users/zsh-history-substring-search /usr/share/zsh/plugins/zsh-history-substring-search
fi
if ! [[ -e "/usr/share/zsh/plugins/zsh-syntax-highlighting" ]]; then
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/zsh/plugins/zsh-syntax-highlighting
fi

# Change shell
if ! [[ -n "$ZSH_VERSION" ]]; then
    chsh -s "/usr/bin/zsh"
fi
