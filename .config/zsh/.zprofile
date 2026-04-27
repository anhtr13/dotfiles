# .zprofile
#

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_RUNTIME_DIR="/run/user/$UID"

export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export CARGODIR="$HOME/.cargo"
export ZIGDIR="$HOME/zig"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin:$CARGODIR/bin:$GOROOT/bin:$GOPATH/bin"
export LLVM_SYMBOLIZER_PATH="/usr/bin/llvm-symbolizer"

export EDITOR="/usr/bin/vim"
# export MANPAGER="nvim +Man!"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"

eval "$(fnm env --use-on-cd --shell zsh)" # Node version manager
# eval $(keychain --eval id_ed25519)
