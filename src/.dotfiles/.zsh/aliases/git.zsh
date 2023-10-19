#!/usr/bin/env zsh

# ==================================================================
# git.zsh
# ==================================================================
# Bash-Bits Modular Bash Library File
#
# File:         git.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
alias gitclean='git clean -df && git checkout -- .'         # discards unstaged changes
alias g='git'
alias gc='gitclean'
alias cc='git commit'
alias cm='git commit -m'
alias gl='git pull'
alias gp='git push'
alias ga='git add'
alias gaa='git add .'
alias gsub='git submodule update --recursive --remote'

alias sdiff="git diff && git submodule foreach 'git diff'"
alias spush='git push --recurse-submodules=on-demand'
alias supdate='git submodule update --remote --merge'
