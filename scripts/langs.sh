#!/usr/bin/env bash
#
# Install some system languages

set -e

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME

# Rust & Cargo
if ! command -v rustc &>/dev/null; then
    printf "\n==> Installing Rust...\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Go
if ! [[ -d "/usr/local/go" ]]; then
    printf "\n==> Installing Go...\n"
    mkdir -p "$target/go"
    cd "$target/go"
    curl -LO https://go.dev/dl/go1.26.0.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.26.0.linux-amd64.tar.gz
    cd $dotdir
fi

# Zig
if ! [[ -d "$target/zig" ]]; then
    printf "\n==> Installing Zig...\n"
    mkdir -p "$target/zig"
    cd "$target/zig"
    curl -LO https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz
    tar -xf zig-x86_64-linux-0.15.2.tar.xz
    cd $dotdir
fi
