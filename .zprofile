# .zprofile
#

if [ -f ~/.profile ]; then
    . ~/.profile
fi

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Node version manager
if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi
