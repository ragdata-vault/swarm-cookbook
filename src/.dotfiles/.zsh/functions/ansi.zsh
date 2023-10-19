#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# ansi.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi.zsh
# Author:       Ragdata
# Date:         19/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
[[ -z "$ANSI_CSI" ]] && source "$ZSHDIR"/functions/ansi_color.zsh
