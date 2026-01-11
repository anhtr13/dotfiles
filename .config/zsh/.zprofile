# .zprofile

if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$XDG_STATE_HOME" ]]; then
  export XDG_STATE_HOME="$HOME/.local/state"
fi

if [[ -z "$XDG_DATA_HOME" ]]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  export XDG_RUNTIME_DIR="/run/user/$UID"
fi

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin"

export EDITOR="/usr/bin/nvim"
export MANPAGER="nvim +Man!" # Use nvim for man page
export MYVIMRC="~/.config/vim/vimrc"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export LLVM_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer

. "$HOME/.cargo/env"

eval "$(fnm env --use-on-cd --shell zsh)" # Node version manager
# eval $(keychain --eval id_ed25519)
