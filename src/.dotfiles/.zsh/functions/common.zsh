#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# ansi::misc.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::misc.zsh
# Author:       Ragdata
# Date:         18/08/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
[[ -z "$ANSI_CSI" ]] && source "$ZSHDIR"/functions/ansi_color.zsh
# ==================================================================
# FUNCTION ALIASES
# ==================================================================
#
# ECHO COLOR ALIASES
#
echoBlack() { echoAlias "$1" -c="${BLACK}" "${@:2}"; }
echoPink() { echoAlias "$1" -c="${PINK}" "${@:2}"; }
echoRed() { echoAlias "$1" -c="${RED}" "${@:2}"; }
echoGreen() { echoAlias "$1" -c="${GREEN}" "${@:2}"; }
echoGold() { echoAlias "$1" -c="${GOLD}" "${@:2}"; }
echoYellow() { echoAlias "$1" -c="${YELLOW}" "${@:2}"; }
echoBlue() { echoAlias "$1" -c="${BLUE}" "${@:2}"; }
echoMagenta() { echoAlias "$1" -c="${MAGENTA}" "${@:2}"; }
echoPurple() { echoAlias "$1" -c="${PURPLE}" "${@:2}"; }
echoCyan() { echoAlias "$1" -c="${CYAN}" "${@:2}"; }
echoGrey() { echoAlias "$1" -c="${GREY}" "${@:2}"; }
echoWhite() { echoAlias "$1" -c="${WHITE}" "${@:2}"; }
#
# ECHO STYLE ALIASES
#
echoDebug() { echoAlias "${ITALIC}$1${NORMAL}" -c="${WHITE}" "${@:2}"; }
echoDefault() { echoAlias "${RESET}$1" "${@:2}"; }
#
# MESSAGE ALIASES
#
echoError() { echoAlias "${SYMBOL_ERROR} $1" -c="${RED}" -e "${@:2}"; }
echoInfo() { echoAlias "${SYMBOL_INFO} $1" -c="${BLUE}" "${@:2}"; }
echoSuccess() { echoAlias "${SYMBOL_SUCCESS} $1" -c="${GREEN}" "${@:2}"; }
echoWarning() { echoAlias "${SYMBOL_WARNING} $1" -c="${GOLD}" "${@:2}"; }
#
# EXIT ALIASES
#
exitReturn() { local r="${1:-0}"; [[ "${BASH_SOURCE[0]:-${(%):-%x}}" != "${0}" ]] && return "$r" || exit "$r"; }
errorExitReturn() { echoError "$1"; exitReturn "${2:-1}"; }
