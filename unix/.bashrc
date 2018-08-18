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
([ -z "$PS1" ] || [ -z "$HOME" ]) && return;

set -o emacs;            # Force Bash's Emacs Mode

shopt -s extglob         # Enable regex pattern matching
shopt -s globstar        # Enable recursive file search
shopt -s checkwinsize    # check (& update) window size after every command
shopt -s histappend      # append to history file, don't overrite

HISTCONTROL=ignoreboth   # no duplicate lines, lines starting with space
HISTFILESIZE=1000        # max num of lines
HISTSIZE=1000            # max num of commands

has_color=0
if [ -t 1 ] && command -v tput > /dev/null 2>&1; then
  ncolors=$(tput colors)
  [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ] && has_color=1
  ncolors=
fi

if [ $has_color -eq 1 ] && ( echo "$PS1" | grep -q debian_chroot ); then
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]\n\$ '
fi

unalias -a

if command -v ls > /dev/null 2>&1; then
  [ $has_color -eq 1 ] && alias ls='\ls --color=auto'
  alias ls.v='ls -x -hks -bF --group-directories-first'
fi

if command -v grep > /dev/null 2>&1; then
  [ $has_color -eq 1 ] && alias grep='\grep --color=auto'
fi

if command -v vim > /dev/null 2>&1; then
  [ -d "$HOME/.vim" ] || mkdir "$HOME/.vim"
  [ -f "$HOME/.vim/vimrc" ] || touch "$HOME/.vim/vimrc"
  alias vim="$(command -v vim) -Nu $HOME/.vim/vimrc"

  if command -v gvim > /dev/null 2>&1; then
    [ -f "$HOME/.vim/gvimrc" ] || touch "$HOME/.vim/gvimrc"
    alias gvim="$(command -v gvim) -Nu $HOME/.vim/vimrc -U $HOME/.vim/gvimrc"
  fi
fi

if command -v nvim > /dev/null 2>&1; then
  [ -d "$HOME/.config/nvim" ] || mkdir "$HOME/.config/nvim"
  [ -f "$HOME/.config/nvim/init.vim" ] || touch "$HOME/.config/nvim/init.vim"
  alias nvim="$(command -v nvim) -u $HOME/.config/nvim/init.vim"
fi

if command -v pngcrush > /dev/null 2>&1; then
  alias pngcrush.f='\pngcrush --brute -l 9'
fi

if command -v desmume > /dev/null 2>&1; then
  alias desmume.jit='\desmume --cpu-mode=1'
fi

if command -v tar > /dev/null 2>&1; then
  alias tar='\tar -v --totals --block-number'
  # Create
  alias tar.c='tar -c --verify -f';   # tar.c  <archive.tar>    <files>
  alias tar.cz='tar -cz -f';          # tar.cz <archive.tar.gz> <files>
  # Extract
  alias tar.x='tar -x -f';            # tar.x  <archive.tar>
  alias tar.xz='tar -xz -f';          # tar.xz <archive.tar.gz>
fi

if command -v youtube-dl > /dev/null 2>&1; then
    [ -d "$HOME/Music" ] || mkdir "$HOME/Music"
    alias ytdl.m='\youtube-dl -f "bestaudio[ext=webm]" -o "$HOME/Music/%(title)s.%(ext)s"'
    [ -d "$HOME/Videos" ] || mkdir "$HOME/Videos"
    alias ytdl.v='\youtube-dl -f "best[ext=webm]" -o "$HOME/Videos/%(title)s.%(ext)s"'
fi

export NVM_DIR="$HOME/.nvm"
[ -d "$NVM_DIR" ] || mkdir "$NVM_DIR"
[ -f "$NVM_DIR/nvm.sh" ] && alias nvm='unalias nvm && \. "$NVM_DIR/nvm.sh" && nvm "$@"'
[ -f "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -f "$HOME/.fzf.bash" ] && \. "$HOME/.fzf.bash"

# Cleanup
has_color=
