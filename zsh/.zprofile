# .zprofile

if
 ! [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    PATH="$PATH:$HOME/.local/bin"
fi


export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

