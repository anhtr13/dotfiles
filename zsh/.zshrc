# zshrc

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh

[[ -f ${ZDOTDIR}/aliasrc ]] && source ${ZDOTDIR}/aliasrc
[[ -f ${ZDOTDIR}/optionrc ]] && source ${ZDOTDIR}/optionrc

HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=9600
SAVEHIST=9600
WORDCHARS='*?~&!#%^<>' # separate words by / - _ = . $ () {} [];

eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/tokyo_night.json)"

zmodload zsh/terminfo

bindkey '^[[1;5C' forward-word               # ctrl + arrow-right
bindkey '^[[1;5D' backward-word              # ctrl + arrow-left
bindkey '^[[3~' delete-char                  # del
bindkey '^[[3;5~' delete-word                # ctrl+del
bindkey '^H' backward-delete-word            # ctrl+backspace
bindkey '^[[A' history-substring-search-up   # arrow-up
bindkey '^[[B' history-substring-search-down # arrow-down
bindkey '^[[107;6u' clear-screen             # ctrl + shift + k
bindkey '^[y' redo                           # Alt + y
bindkey '^[z' undo                           # Alt + z

zstyle :compinstall $ZDOTDIR/.zshrc

autoload -Uz compinit
compinit

echo -en "\e]0;$PWD\a" #-- Set icon name and window title to $PWD

function chpwd() {
  echo -en "\e]0;$PWD\a" #-- Set icon name and window title after cd
}

# Load (uncomment) when needed
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/plugins/zsh-syntax-highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
