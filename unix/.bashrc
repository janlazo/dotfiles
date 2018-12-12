# Copyright 2018 Jan Edmund Doroin Lazo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
test -d "$HOME" || return
test -d "$HOME/bin" && export PATH="$HOME/bin:$PATH"
test -d "$HOME/.local/bin" && export PATH="$HOME/.local/bin:$PATH"

set -o emacs

shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s histappend

HISTCONTROL=ignoreboth:erasedups
HISTFILESIZE=1000
HISTSIZE=1000

has_color=0
if test -t 1 && command -v tput > /dev/null 2>&1; then
  ncolors=$(tput colors)
  test -n "$ncolors" && test "$ncolors" -ge 8 && has_color=1
  unset -v ncolors
fi

unalias -a

test $has_color -eq 1 && alias ls="$(command -v ls) --color=auto"
alias ls.v='ls -x -hks -bF --group-directories-first'

test $has_color -eq 1 && alias grep="$(command -v grep) --color=auto"

alias tar="$(command -v tar) -v --totals --block-number"
# Create
# tar.c  <archive.tar>    <files>
# tar.cz <archive.tar.gz> <files>
alias tar.c='tar -c --verify -f'
alias tar.cz='tar -cz -f'
# Extract
# tar.x  <archive.tar>
# tar.xz <archive.tar.gz>
alias tar.x='tar -x -f'
alias tar.xz='tar -xz -f'

export NVM_DIR="$HOME/.nvm"
test -d "$NVM_DIR" || mkdir "$NVM_DIR"
test -f "$NVM_DIR/nvm.sh" && \. "$NVM_DIR/nvm.sh" --no-use
test -f "$NVM_DIR/bash_completion" && \. "$NVM_DIR/bash_completion"

if command -v ruby > /dev/null 2>&1 &&
    command -v gem > /dev/null 2>&1; then
  gem_user_dir="$(ruby -r rubygems -e 'puts Gem.user_dir')"
  test -d "$gem_user_dir" &&
    test -d "$gem_user_dir/bin" &&
    export PATH="$gem_user_dir/bin:$PATH"
  unset -v gem_user_dir
fi

test -d "$HOME/.vim" || mkdir "$HOME/.vim"
test -f "$HOME/.vim/vimrc" || touch "$HOME/.vim/vimrc"
test -f "$HOME/.vim/gvimrc" || touch "$HOME/.vim/gvimrc"
if command -v vim.tiny > /dev/null 2>&1; then
  alias vim.tiny="$(command -v vim.tiny) -u $HOME/.vim/vimrc"
fi
if command -v vim > /dev/null 2>&1; then
  alias vim="$(command -v vim) -u $HOME/.vim/vimrc"
  alias gvim="vim -g -U $HOME/.vim/gvimrc"
fi

test -d "$HOME/.config/nvim" || mkdir "$HOME/.config/nvim"
test -f "$HOME/.config/nvim/init.vim" || touch "$HOME/.config/nvim/init.vim"
if command -v nvim > /dev/null 2>&1; then
  alias nvim="$(command -v nvim) -u $HOME/.config/nvim/init.vim"
fi

if command -v pngcrush > /dev/null 2>&1; then
  alias pngcrush.f='pngcrush --brute -l 9'
fi

if command -v desmume > /dev/null 2>&1; then
  alias desmume.jit='desmume --cpu-mode=1'
fi

if command -v youtube-dl > /dev/null 2>&1; then
  test -d "$HOME/Music" || mkdir "$HOME/Music"
  alias ytdl.m="youtube-dl -f 'bestaudio[ext=webm]' -o '$HOME/Music/%(title)s.%(ext)s'"
  test -d "$HOME/Videos" || mkdir "$HOME/Videos"
  alias ytdl.v="youtube-dl -f 'best[ext=webm]' -o '$HOME/Videos/%(title)s.%(ext)s'"
fi

test -f "$HOME/.fzf.bash" && \. "$HOME/.fzf.bash"

case $(uname -s) in
  Darwin)
    export HOMEBREW_NO_ANALYTICS=1
    ;;
  Linux)
    if test $has_color -eq 1 && (echo "$PS1" | grep -q debian_chroot); then
      export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]\n\$ '
    fi
    ;;
esac

test -f "$HOME/.bashrc_local" && \. "$HOME/.bashrc_local"

# Cleanup
unset -v has_color
