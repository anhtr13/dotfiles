# .zprofile
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
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
    export XDG_RUNTIME_DIR="/run/user/$UID"
fi

export EDITOR="vim"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
# export MANPAGER="nvim +Man!"

export LLVM_SYMBOLIZER_PATH="/usr/bin/llvm-symbolizer"

export GOROOT="/usr/lib/go"
export GOPATH="$HOME/go"
export CARGO_HOME="$HOME/.cargo"
export ZIG_HOME="$HOME/zig/current"

append_path "$HOME/.local/bin"
append_path "$ZIG_HOME/bin"
append_path "$GOPATH/bin"
append_path "$CARGO_HOME/bin"

eval "$(fnm env --use-on-cd --shell zsh)" # Node version manager
# eval $(keychain --eval id_ed25519)
