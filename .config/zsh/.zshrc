# zshrc

# https://github.com/zsh-users/zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/zsh-users/zsh-history-substring-search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

[[ -f ${ZDOTDIR}/aliasrc ]] && source ${ZDOTDIR}/aliasrc
[[ -f ${ZDOTDIR}/optionrc ]] && source ${ZDOTDIR}/optionrc

HISTFILE=$ZDOTDIR/.histfile
HISTSIZE=9600
SAVEHIST=9600
WORDCHARS='*?~&!#%^<>' # separate words by / - _ = . $ () {} [];

eval "$(starship init zsh)"

zmodload zsh/terminfo

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey '^v' vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# Other key-bindings
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

echo -en "\e]0;$PWD\a" #-- Set icon name and window title to $PWD
function chpwd() {
    echo -en "\e]0;$PWD\a" #-- Set icon name and window title after cd
}

# https://github.com/zsh-users/zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
