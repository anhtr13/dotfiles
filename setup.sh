#! /bin/bash

here=$(dirname "$(realpath "$0")")
target=$HOME
track_dirs=(
    ".config"
    ".local"
    ".doom.d"
)

sudo pacman -S --needed base-devel git

##############################
# Copy config files
##############################

for dir in "${track_dirs[@]}"; do
    mkdir -p "$target/$dir"
    cp -r "$here/$dir" "$target/$dir"
done

##############################
# Zsh
##############################

# System-wide zshenv
if ! [[ -f /etc/zsh/zshenv ]]; then
    sudo mkdir -p /etc/zsh && sudo touch /etc/zsh/zshenv
fi
cat "$here/.config/zsh/etc-zsh-zshenv" | sudo tee /etc/zsh/zshenv

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

# ##############################
# # Setup AUR
# ##############################

if ! $(pacman -Q yay >/dev/null); then
    git clone https://aur.archlinux.org/yay.git $HOME/yay
    cd $HOME/yay
    makepkg -si
    cd $here
fi

# ##############################
# # Install core packages
# ##############################

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
done <"$here/installed_packages.txt"

pkgs_to_install=($(comm -12 <(pacman -Slq | sort -u) <(printf '%s\n' "${pkgs[@]}" | sort -u)))
sudo pacman -S --needed "${pkgs_to_install[@]}"

pkgs_not_found=($(comm -23 <(printf '%s\n' "${pkgs[@]}" | sort -u) <(printf '%s\n' "${pkgs_to_install[@]}" | sort -u)))
printf "\\n--------------------------------------------------\\nPackages not found and ignored:\\n\\n"
printf "%s\\n" "${pkgs_not_found[@]}"
