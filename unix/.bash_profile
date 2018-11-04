(test -d "$HOME" && test -f "$HOME/.bashrc") || return
. "$HOME/.bashrc"
test -d "$HOME/bin" && export PATH="$HOME/bin:$PATH"
