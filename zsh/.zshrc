
# Load optionrc if it exists
[[ -f ${ZDOTDIR}/optionrc ]] && source ${ZDOTDIR}/optionrc

# Plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

# History
HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=9600
SAVEHIST=9600

# Words separating
WORDCHARS='*?[]~&!#$%^(){}<>'  # separate words by / - _ = . ;

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

bindkey '^[y'     redo                 # Alt + y
bindkey '^[z'     undo                 # Alt + z

# Completion
zstyle :compinstall $ZDOTDIR/.zshrc

autoload -Uz compinit
compinit

# Aliases


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Init zsh-themes via oh-my-posh
system=$(gsettings get org.gnome.desktop.interface color-scheme)
[[ $system =~ 'dark' ]] \
	&& eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/tokyo_night.json)" \
	|| eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/tokyo_day.json)"


