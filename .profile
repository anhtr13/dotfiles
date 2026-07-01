# .profile
#

append_path() {
    case ":$PATH:" in
    *:"$1":*)
        ;;
    *)
        PATH="$1${PATH:+:$PATH}"
        ;;
    esac
}

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
if [ -z "$XDG_RUNTIME_DIR" ]; then
    export XDG_RUNTIME_DIR="/run/user/$UID"
fi

export EDITOR="vim"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
# export MANPAGER="nvim +Man!"

export LLVM_SYMBOLIZER_PATH="/usr/bin/llvm-symbolizer"

if command -v starship &>/dev/null; then
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
fi

append_path "$HOME/.local/bin"

if command -v go &>/dev/null; then
    export GOROOT="/usr/lib/go"
    export GOPATH="$HOME/go"
    append_path "$GOPATH/bin"
fi

if command -v cargo &>/dev/null; then
    export CARGO_HOME="$HOME/.cargo"
    append_path "$CARGO_HOME/bin"
fi

# eval $(keychain --eval id_ed25519)
