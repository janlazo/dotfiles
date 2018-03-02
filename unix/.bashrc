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
[ -z "$PS1" ] && return; # don't do anything if not running interactively

set -o emacs;            # Force Bash's Emacs Mode

shopt -s extglob         # Enable regex pattern matching
shopt -s globstar        # Enable recursive file search
shopt -s checkwinsize    # check (& update) window size after every command
shopt -s histappend      # append to history file, don't overrite

HISTCONTROL=ignoreboth   # no duplicate lines, lines starting with space
HISTFILESIZE=1000        # max num of lines
HISTSIZE=100             # max num of commands

has_color=0
if [ -t 1 ] && command -v tput > /dev/null 2>&1; then
  ncolors=$(tput colors)
  [ -n "$ncolors" ] && [ $ncolors -ge 8 ] && has_color=1
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

if command -v node > /dev/null 2>&1; then
  export NVM_DIR="$HOME/.nvm"
  [ -d "$NVM_DIR" ] || mkdir "$NVM_DIR"
  [ -f "$NVM_DIR/nvm.sh" ] && alias nvm='unalias nvm && . "$NVM_DIR/nvm.sh" && nvm "$@"'
fi

# Cleanup
has_color=
