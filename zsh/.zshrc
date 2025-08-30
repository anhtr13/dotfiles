# zshrc

# Load optionrc if it exists
[[ -f ${ZDOTDIR}/optionrc ]] && source ${ZDOTDIR}/optionrc
# Load aliasrc if it exists
[[ -f ${ZDOTDIR}/aliasrc ]] && source ${ZDOTDIR}/aliasrc

# Plugins
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

# Init zsh-themes via starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
eval "$(starship init zsh)"

# Init zsh-themes via oh-my-posh
# eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/tokyo_night.json)"

export MANPAGER="nvim +Man!"

# Envs
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=9600
SAVEHIST=9600
WORDCHARS='*?~&!#%^<>' # separate words by / - _ = . $ () {} [];

# Bind keys
zmodload zsh/terminfo

bindkey '^[[1;5C' forward-word  # ctrl + arrow-right
bindkey '^[[1;5D' backward-word # ctrl + arrow-left

bindkey '^[[3~' delete-char       # del
bindkey '^[[3;5~' delete-word     # ctrl+del
bindkey '^H' backward-delete-word # ctrl+backspace

bindkey '^[[A' history-substring-search-up   # arrow-up
bindkey '^[[B' history-substring-search-down # arrow-down

bindkey '^[[107;6u' clear-screen # ctrl + shift + k

bindkey '^[y' redo # Alt + y
bindkey '^[z' undo # Alt + z

# Completion
zstyle :compinstall $ZDOTDIR/.zshrc

autoload -Uz compinit
compinit

# Run on startup
echo -en "\e]0;$PWD\a" #-- Set icon name and window title to $PWD

# Hooks
function chpwd() {
  echo -en "\e]0;$PWD\a" #-- Set icon name and window title after cd
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
