#! /bin/bash

here=$(dirname "$(realpath "$0")")
target=$HOME
track_dirs=(
    ".config"
    ".local"
    ".doom.d"
)

##############################
# Yay for AUR
##############################

sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git $HOME/yay
cd $HOME/yay
makepkg -si
cd $here

##############################
# Install core packages
##############################

pkgs=()
while IFS= read -r line; do
    pkgs+=("$line")
done <"$here/installed_packages.txt"

pkgs_to_install=($(comm -12 <(yay -Slq | sort -u) <(printf '%s\n' "${pkgs[@]}" | sort -u)))
yay -S "${pkgs_to_install[@]}"

pkgs_not_found=($(comm -23 <(printf '%s\n' "${pkgs[@]}" | sort -u) <(printf '%s\n' "${pkgs_to_install[@]}" | sort -u)))
printf "\\n--------------------------------------------------\\nPackages not found and ignored:\\n\\n"
printf "%s\\n" "${pkgs_not_found[@]}"

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
sudo cp -r "$here/.config/zsh/etc-zsh-zshenv" /etc/zsh/zshenv

# Zsh plugins
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-history-substring-search /usr/share/zsh/plugins/zsh-history-substring-search
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting /usr/share/zsh/plugins/zsh-syntax-highlighting
