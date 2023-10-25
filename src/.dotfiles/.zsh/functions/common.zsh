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
source "$ZSHDIR"/functions/regex_aliases.zsh
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
#
# BASIC SYSTEM FUNCTIONS
#
mkcd() { mkdir -p "$@"; cd "$1" || return 1; }
mkcp() { mkdir -p "$(dirname "$2")"; cp "$1" "$2"; }

history_stats()
{
	if [ -z "$1" ]; then
		entries=1000
	else
		entries="$1"
	fi
	history -15000 \
			| awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
			| rg -v "./" \
			| column -c3 -s " " -t \
			| sort -nr \
			| nl \
			| head -n"$entries"
}

pf()
{
	pid="$(ps -ef | sed 1d | fzf -m | awk '{print $2}')"

	if [ "x$pid" != "x" ]; then
		echo "$pid"
	fi
}

# list only killable processes
pfu()
{
	uid="$(bash -c 'echo $UID')"
	if [ "$uid" != 0 ]; then
		pid=$(ps -f -u "$uid" | sed 1d | fzf -m -q "$@" | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m -q "$@" | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo "$pid"
	fi
}

fkill()
{
	if [ $# -eq 0 ]; then
		signal=9
	else
		signal="$1"
	fi
	pfu "$2" | xargs kill -"$signal"
}

if command -v jq && command -v yq; then
	# JQ FOR YAML
	# [YQ](https://github.com/mikefarah/yq) uses unfamiliar syntax
	# So, just convert the YAML to JSON, run it through JQ, then convert back to YAML
	# Surround the JQ commands in quotes so that it's treated as a single argument
	jqy()
	{
		yq r -j "$1" | jq "$2" | yq - r
	}
fi

ghsearch_repos()
{
	formatstr="$(echo "$*" | tr ' ' '+')"
	printf 'https://github.com/search?q=%s&type=Repositories' "$formatstr"
}

ghsearch_starred()
{
	baseurl="$(ghsearch_repos "$*")"
	echo "${baseurl}&o=desc&s=starred"
}

ghsearch() { $BROWSER "$(ghsearch_repos "$*")"; }
ghssearch() { $BROWSER "$(ghsearch_starred "$*")"; }
