#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2034,SC2154,SC2155,SC2181
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
# VARIABLES
# ==================================================================
if [[ -z "$REPO" ]]; then export REPO="$(dirname "$(dirname "$(realpath "${0:h}")")")"; fi
# ==================================================================
# LOADERS
# ==================================================================
# ------------------------------------------------------------------
# loadLib
# ------------------------------------------------------------------
if ! typeset -f loadLib > /dev/null; then
	loadLib()
	{
		local file="${1:-}"

		if [[ "${1:0:1}" == "/" ]] && [[ -f "$file" ]]; then
			source "$file"
		elif [[ -f /usr/local/lib/"$file" ]]; then
			source /usr/local/lib/"$file"
		elif [[ -f "$REPO"/src/lib/"$file" ]]; then
			source "$REPO"/src/lib/"$file"
		else
			echo "Library File '$file' Not Found!"
			exit 1
		fi
	}
fi
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! typeset -f ansi::color > /dev/null; then loadLib ansi_color.zsh; fi
if ! typeset -f regex::isCC > /dev/null; then loadLib regex_aliases.zsh; fi
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
# ------------------------------------------------------------------
# checkFunc
# ------------------------------------------------------------------
checkFunc() { if typeset -f "$1" > /dev/null; then return 0; else return 1; fi; }
# ------------------------------------------------------------------
# checkPkg
# ------------------------------------------------------------------
checkPkg()
{
	local pkg="${1:-}"
	local name="${2:-}"

	if [[ -z "$pkg" ]] || [[ -z "$name" ]]; then echo "Missing Argument(s)!"; exit 1; fi

	if loadSource "$pkg" -d; then
		log::file "Found '$name'"
	else
		loadSource "$pkg" -i
		if [ "$?" -ne 0 ]; then log::file "Failed installing '$name' - exiting ..."; exit 1; fi
	fi
}
# ------------------------------------------------------------------
# checkRoot
# ------------------------------------------------------------------
checkRoot()
{
	if [ $EUID -ne 0 ]; then
		echo "This script MUST be run as root!"
		exit 1
	fi
}
# ------------------------------------------------------------------
# checkShell
# ------------------------------------------------------------------
checkShell()
{
	local SHELL_VERSION

	if [[ "${SHELL##*/}" == "zsh" ]]; then
		SHELL_VERSION="${ZSH_VERSION}"
	else
		SHELL_VERSION="${BASH_VERSION}"
	fi

	if [[ ${SHELL_VERSION:0:1} -lt 4 ]]; then
		echo "This script requires a minimum Bash / ZSH version of 4!"
		exit 1
	fi
}
# ------------------------------------------------------------------
# colorGrid
# ------------------------------------------------------------------
colorGrid() { for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done; }
# ------------------------------------------------------------------
# getPassword
# ------------------------------------------------------------------
getPassword()
{
	local len="${1:-16}"
	local NUM_REGEX CAP_REGEX SML_REGEX SYM_REGEX
	local passwd=""

	NUM_REGEX='^.*[0-9]+.*$'
	CAP_REGEX='^.*[A-Z]+.*$'
	SML_REGEX='^.*[a-z]+.*$'
	SYM_REGEX='^[A-Za-z0-9]+[@#%_+=][A-Za-z0-9]+$'

	while [[ ! $passwd =~ $NUM_REGEX ]] && [[ ! $passwd =~ $CAP_REGEX ]] && [[ ! $passwd =~ $SML_REGEX ]] && [[ ! $passwd =~ $SYM_REGEX ]]
	do
		passwd=$(tr </dev/urandom -dc 'A-Za-z0-9@#%_+=' | head -c "$len")
	done

	echo "$passwd"
}
# ------------------------------------------------------------------
# historyStats
# ------------------------------------------------------------------
historyStats()
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
# ------------------------------------------------------------------
# loadSource
# ------------------------------------------------------------------
loadSource()
{
	local app="${1:-}"
	local options dir fileName fullPath filePath pathName
	local -A FILEOPTS

	if [[ -z "$app" ]]; then echo "Missing Argument!"; exit 1; fi

	shift

	fileName="${app##*/}"
	fileName="${fileName%%.*}"

	FILEOPTS[installed]=0
	FILEOPTS[install]=0
	FILEOPTS[config]=0
	FILEOPTS[remove]=0
	FILEOPTS[test]=0

	options=$(getopt -o "cdirt" -a -- "$@")

	eval set -- "$options"

	while true
	do
		case "$1" in
			-c) FILEOPTS[config]=1;;
			-d) FILEOPTS[installed]=1;;
			-i) FILEOPTS[install]=1;;
			-r) FILEOPTS[remove]=1;;
			-t) FILEOPTS[test]=1;;
			--)
				shift
				break
				;;
			*)
				echo "loadSource :: Invalid Option '$1'"
				exit 1
				;;
		esac
		shift
	done

	if [[ -f "$app" ]]; then
		fullPath="$app"
	else
		if [[ $DEBUG -eq 1 ]]; then log::file "Finding '$app'"; fi
		if [[ ! "$app" = *.* ]]; then thisFile="$app".zsh; else thisFile="$app"; fi
		for dir in "${SOURCE_DIRS[@]}"
		do
			if [[ $DEBUG -eq 1 ]]; then log::file "Searching '$dir'"; fi
			if [[ -f "$dir/$thisFile" ]]; then fullPath="$dir/$thisFile"; break; fi
		done
	fi

	if [[ -z "$fullPath" ]] || [[ ! -f "$fullPath" ]]; then log::file "File '$app' Not Found!"; exit 1; fi

	source "$fullPath"

	# INSTALLED
	if [[ "${FILEOPTS[installed]}" -eq 1 ]]; then
		log::file "Checking if '$fileName' installed"
		eval "$fileName::installed"
		return $?
	fi
	# INSTALL & REMOVE
	if [[ "${FILEOPTS[install]}" -eq 1 ]]; then
		log::file "Installing '$fileName'"
		eval "$fileName::install $logFile"
		return $?
	elif [[ "${FILEOPTS[remove]}" -eq 1 ]]; then
		log::file "Uninstalling '$fileName'"
		eval "$fileName::remove $logFile"
		return $?
	fi
	# CONFIGURE
	if [[ "${FILEOPTS[config]}" -eq 1 ]]; then
		log::file "Configuring '$fileName'"
		eval "$fileName::config $logFile"
		return $?
	fi
	# TEST
	if [[ "${FILEOPTS[test]}" -eq 1 ]]; then
		log::file "Testing '$fileName'"
		eval "$fileName::test $logFile"
		return $?
	fi
}
# ------------------------------------------------------------------
# log::file
# ------------------------------------------------------------------
log::file()
{
	local msg="${1:-}" timestamp

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$logFile" ]] && { echo "LogFile '$logFile' Not Found!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi
	echo "$timestamp :: $USERNAME - $msg" | sudo tee -a "$logFile" > /dev/null
}
# ------------------------------------------------------------------
# log::redis
# ------------------------------------------------------------------
log::redis()
{
	local key="${1:-}" timestamp
	local val="${2:-}"

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ -z "$REDISCLI_AUTH" ]] && { echo "Redis Authentication Missing!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi

	redis-cli "$logFile" "$key" "$val" > /dev/null
}
# ------------------------------------------------------------------
# redis::passGET
# ------------------------------------------------------------------
redis::passGET() { sudo sed -n -e '/^requirepass.*/p' /etc/redis/redis.conf | awk '{print $2}'; }
# ------------------------------------------------------------------
# pf
# ------------------------------------------------------------------
pf()
{
	pid="$(ps -ef | sed 1d | fzf -m | awk '{print $2}')"

	if [ "x$pid" != "x" ]; then
		echo "$pid"
	fi
}
# ------------------------------------------------------------------
# pfu
# ------------------------------------------------------------------
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
# ------------------------------------------------------------------
# fkill
# ------------------------------------------------------------------
fkill()
{
	if [ $# -eq 0 ]; then
		signal=9
	else
		signal="$1"
	fi
	pfu "$2" | xargs kill -"$signal"
}
# ------------------------------------------------------------------
# jqy
# ------------------------------------------------------------------
if command -v jq > /dev/null && command -v yq; then
	# JQ FOR YAML
	# [YQ](https://github.com/mikefarah/yq) uses unfamiliar syntax
	# So, just convert the YAML to JSON, run it through JQ, then convert back to YAML
	# Surround the JQ commands in quotes so that it's treated as a single argument
	jqy()
	{
		yq r -j "$1" | jq "$2" | yq - r
	}
fi
# ------------------------------------------------------------------
# ghsearchRepos
# ------------------------------------------------------------------
ghsearchRepos()
{
	formatstr="$(echo "$*" | tr ' ' '+')"
	printf 'https://github.com/search?q=%s&type=Repositories' "$formatstr"
}
# ------------------------------------------------------------------
# ghsearchStarred
# ------------------------------------------------------------------
ghsearchStarred()
{
	baseurl="$(ghsearchRepos "$*")"
	echo "${baseurl}&o=desc&s=starred"
}
# ------------------------------------------------------------------
# ghsearch
# ------------------------------------------------------------------
ghsearch() { $BROWSER "$(ghsearchRepos "$*")"; }
# ------------------------------------------------------------------
# ghssearch
# ------------------------------------------------------------------
ghssearch() { $BROWSER "$(ghsearchStarred "$*")"; }
