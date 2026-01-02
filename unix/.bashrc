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
alias ls.v='ls -x -hks -bF --group-directories-first'
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

if test $has_color -eq 1; then
  alias ls="$(command -v ls) --color=auto"
  alias grep="$(command -v grep) --color=auto"
fi

# Python
export PIP_DISABLE_PIP_VERSION_CHECK=1

# Ruby
if command -v ruby > /dev/null 2>&1 &&
    command -v gem > /dev/null 2>&1; then
  gem_user_dir="$(ruby -r rubygems -e 'puts Gem.user_dir')"
  test -d "$gem_user_dir" &&
    test -d "$gem_user_dir/bin" &&
    export PATH="$gem_user_dir/bin:$PATH"
  unset -v gem_user_dir
fi

# .NET
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Vim
test -d "$HOME/.vim" || mkdir "$HOME/.vim"
test -f "$HOME/.vim/vimrc" || touch "$HOME/.vim/vimrc"
if command -v vim.tiny > /dev/null 2>&1; then
  alias vim.tiny="$(command -v vim.tiny) -u $HOME/.vim/vimrc"
fi
if command -v vim > /dev/null 2>&1; then
  alias vim="$(command -v vim) -u $HOME/.vim/vimrc"
  alias gvim="vim -g -U NONE"
fi

# Neovim
test -d "$HOME/.config/nvim" || mkdir -p "$HOME/.config/nvim"
test -f "$HOME/.config/nvim/init.vim" || touch "$HOME/.config/nvim/init.vim"
if command -v nvim > /dev/null 2>&1; then
  alias nvim="$(command -v nvim) -u $HOME/.config/nvim/init.vim"
fi

# pngcrush - image compressor
if command -v pngcrush > /dev/null 2>&1; then
  alias pngcrush.f='pngcrush --brute -l 9'
fi

# Desume - 3DS emulator
if command -v desmume > /dev/null 2>&1; then
  alias desmume.jit='desmume --cpu-mode=1'
fi

# Fzf
test -f "$HOME/.fzf.bash" && source "$HOME/.fzf.bash"

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

test -f "$HOME/.bashrc_local" && source "$HOME/.bashrc_local"

# yt-dlp - youtube-dl fork, audio/video downloader
test -d "$HOME/Music" || mkdir "$HOME/Music"
test -d "$HOME/Videos" || mkdir "$HOME/Videos"
if command -v yt-dlp > /dev/null 2>&1; then
  alias yt-dlp.m="yt-dlp -f 'bestaudio[ext=webm]' -o '$HOME/Music/%(title)s.%(ext)s'"
  alias yt-dlp.v="yt-dlp -f 'bestvideo[ext=webm]+bestaudio[ext=webm]' -o '$HOME/Videos/%(title)s.%(ext)s'"
fi

# Cleanup
unset -v has_color
