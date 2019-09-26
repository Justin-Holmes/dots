if [[ -f $HOME/.bashrc ]]; then source $HOME/.bashrc; fi

# Golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Ruby
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Python
eval "$(pyenv init -)"
