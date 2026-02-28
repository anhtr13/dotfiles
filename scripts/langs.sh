#!/usr/bin/env bash
#
# Necessary system languages
#

dotdir=$(dirname $(dirname $(realpath "$0")))
target=$HOME

# Rust & Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Go
if ! [[ -d "/usr/local/go" ]]; then
    mkdir -p "$target/go"
    cd "$target/go"
    curl -O -L https://go.dev/dl/go1.26.0.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.26.0.linux-amd64.tar.gz
    cd $dotdir
fi

# Zig
if ! [[ -d "$target/zig" ]]; then
    mkdir -p "$target/zig"
    cd "$target/zig"
    curl -O -L https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz
    tar -xf zig-x86_64-linux-0.15.2.tar.xz
    cd $dotdir
fi
