#!/usr/bin/env zsh

# ==================================================================
# zsh.zsh
# ==================================================================
# Bash-Bits Modular Bash Library File
#
# File:         zsh.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# ALIASES
# ==================================================================
if [ -n "$ZSH_VERSION" ]; then
	timefile() { printf '%s%s' "$(date -Iseconds)" ".$1"; }
	alias -g ez='exec zsh'
	alias -g isotime='$(date -u -Iseconds)'
	alias -g nnote='$(timefile md)'
	alias -g todaynote='"$(date -u +%Y-%m-%d)"*'
	alias -g detch='&> /dev/null 2> /dev/null & disown'
fi
