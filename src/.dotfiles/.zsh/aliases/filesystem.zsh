#!/usr/bin/env zsh

# ==================================================================
# filesystem.zsh
# ==================================================================
# Bash-Bits Modular Bash Library File
#
# File:         filesystem.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Improve Existing Commands
alias df='df -h'
alias free='free -h'
alias uptime='uptime -p'
alias rmf='rm -rf'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias lgrep='ll | grep'                                     # find a file in the current dir
alias fdir='find . -type d -name'                           # find a dir by name in the current dir
alias ff='find . -type f -name'                             # find a file by name in the current dir
alias ffix='sudo chown -R "${USER:-$(id -un)}" .'           # fix fx permission errors

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ~='cd ~'
alias -- -='cd -'
