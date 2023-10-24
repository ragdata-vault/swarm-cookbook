#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2031,SC2034,SC2154,SC2155,SC2181,SC2260
# ==================================================================
# install.sh
# ==================================================================
# Dialog Dojo Installer
#
# File:         install.sh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# PREFLIGHT
# ==================================================================
# set debug mode = false
if [[ -z "$DEBUG" ]]; then declare -gx DEBUG=0; fi
# if script is called with 'debug' as an argument, then set debug mode
if [[ "${1:l}" == "debug" ]] || [[ "$DEBUG" == 1 ]]; then shift; DEBUG=1; set -- "${@}"; set -axeET; else set -aeET; fi
if [[ "${1:l}" == "verbose" ]] || [[ "$LOG_VERBOSE" == 1 ]]; then shift; LOG_VERBOSE=1; else LOG_VERBOSE=0; fi
# ==================================================================
# VARIABLES
# ==================================================================
if [[ -z "$REPO" ]]; then export REPO="$(dirname "$(realpath "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")")"; fi
SOURCE_DIRS=("$REPO/src/var/apps" "$REPO/install")
logFile="$(mktemp -t INSTALL-XXXXXX)"
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ ! -f .env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
chown "$USERNAME":"$USERNAME" "$REPO"/.env
source "$REPO"/.env
# ==================================================================
# FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# install::install
# ------------------------------------------------------------------
install::install()
{
	local logFile="${1:-}"
	local source logFile

	echo
	echo "=================================================================="
	echo "FULL INSTALLATION"
	echo "=================================================================="
	echo

	install::loadSource config.sh "$logFile" -i
	install::loadSource dotfiles.sh "$logFile" -i
	install::loadSource bin.sh "$logFile" -i
	install::loadSource swarm.sh "$logFile" -i

	echo
	echo "FULL INSTALLATION - DONE!"
	echo "=================================================================="
	echo
}
# ------------------------------------------------------------------
# install::init
# ------------------------------------------------------------------
install::init()
{
	local logFile="${1:-}"
	local -A PACKAGES

	echo
	echo "=================================================================="
	echo "SYSTEM INITIALIZATION"
	echo "=================================================================="
	echo

	install::checkPkg "jq" "JQ" "$logFile"
	install::checkPkg "redis" "Redis" "$logFile"

	echo
	echo "SYSTEM INITIALIZATION - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::uninstall
# ------------------------------------------------------------------
install::uninstall()
{
	cd /usr/local/bin || return 1
	rm -f app* stack* swarm*
	rm -Rf "${ZSHDIR?}"
	rm -Rf "${SWARMDIR?}"
}
# ------------------------------------------------------------------
# install::report
# ------------------------------------------------------------------
install::report()
{
	local logFile="${1:-}"
	local resp

	[[ -z "$logFile" ]] && { echo "No logFile passed for reporting!"; exit 1; }

	clear

	echo "The previous operation was logged and details are available to view"
	echo "Please select from the following options:"
	echo -e "\t (V)iew Logs"
	echo -e "\t (R)eboot"
	echo -e "\t (Q)uit"
	read -r -n 1 resp

	case "${resp:l}" in
		v)
			echo
			cat "$logFile"
			exit 0
			;;
		r)
			reboot
			;;
		*)
			clear
			;;
	esac
}
# ------------------------------------------------------------------
# install::checkPkg
# ------------------------------------------------------------------
install::checkPkg()
{
	local pkg="${1:-}"
	local name="${2:-}"
	local logFile="${3:-}"

	if [[ -z "$pkg" ]] || [[ -z "$name" ]] || [[ -z "$logFile" ]]; then echo "Missing Argument(s)!"; exit 1; fi

	if install::loadSource "$pkg" "$logFile" -d; then
		install::log "Found '$name'" "$logFile"
	else
S		install::loadSource "$pkg" "$logFile" -i
		if [ "$?" -ne 0 ]; then install::log "Failed installing '$name' - exiting ..." "$logFile"; exit 1; fi
	fi
}
# ------------------------------------------------------------------
# install::checkRoot
# ------------------------------------------------------------------
install::checkRoot()
{
	local tmpFile="$(mktemp)" ID

	id -u > "$tmpFile"

	ID="$(cat "$tmpFile")"

	if [[ $ID != 0 ]]; then
		echo "This script MUST be run as root!"
		exit 1
	fi
}
# ------------------------------------------------------------------
# install::checkShell
# ------------------------------------------------------------------
install::checkShell()
{
	declare -gx SHELL_TYPE
	declare -gx SHELL_VERSION

	SHELL_TYPE="$SHELL"
	SHELL_TYPE="${SHELL_TYPE##*/}"

	if [[ "$SHELL_TYPE" == "zsh" ]]; then
		SHELL_VERSION="$ZSH_VERSION"
	else
		SHELL_VERSION="$BASH_VERSION"
	fi

	if [ "${SHELL_VERSION:0:1}" -lt 4 ]; then
		echo "This script requires a minimum Bash / ZSH version of 4!"
		exit 1
	fi
}
# ------------------------------------------------------------------
# install::getPassword
# ------------------------------------------------------------------
install::getPassword()
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
# install::loadSource
# ------------------------------------------------------------------
install::loadSource()
{
	local app="${1:-}"
	local logFile="${2:-}"
	local options dir fileName fullPath filePath pathName
	local -A FILEOPTS

	if [[ -z "$app" ]] || [[ -z "$logFile" ]]; then echo "Missing Argument(s)!"; exit 1; fi

	shift 2

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
				echo "loadSource :: Invalid Option '$1'" "$logFile"
				exit 1
				;;
		esac
		shift
	done

	if [[ -f "$app" ]]; then
		fullPath="$app"
	else
		if [[ $DEBUG -eq 1 ]]; then install::log "Finding '$app'" "$logFile"; fi
		if [[ ! "$file" = *.* ]]; then thisFile="$file".zsh; else thisFile="$file"; fi
		for dir in "${SOURCE_DIRS[@]}"
		do
			if [[ $DEBUG -eq 1 ]]; then install::log "Searching '$dir'" "$logFile"; fi
			if [[ -f "$dir/$thisFile" ]]; then fullPath="$dir/$thisFile"; break; fi
		done
	fi

	if [[ -z "$fullPath" ]] || [[ ! -f "$fullPath" ]]; then install::log "File '$app' Not Found!" "$logFile"; exit 1; fi

	source "$fullPath"

	# INSTALLED
	if [[ "${FILEOPTS[installed]}" -eq 1 ]]; then
		install::log "Checking if '$fileName' installed" "$logFile"
		eval "$fileName::installed"
		return $?
	fi
	# INSTALL & REMOVE
	if [[ "${FILEOPTS[install]}" -eq 1 ]]; then
		install::log "Installing '$fileName'" "$logFile"
		eval "$fileName::install $logFile"
		return $?
	elif [[ "${FILEOPTS[remove]}" -eq 1 ]]; then
		install::log "Uninstalling '$fileName'" "$logFile"
		eval "$fileName::remove $logFile"
		return $?
	fi
	# CONFIGURE
	if [[ "${FILEOPTS[config]}" -eq 1 ]]; then
		install::log "Configuring '$fileName'" "$logFile"
		eval "$fileName::config $logFile"
		return $?
	fi
	# TEST
	if [[ "${FILEOPTS[test]}" -eq 1 ]]; then
		install::log "Testing '$fileName'" "$logFile"
		eval "$fileName::test $logFile"
		return $?
	fi
}
# ------------------------------------------------------------------
# install::log
# ------------------------------------------------------------------
install::log()
{
	local msg="${1:-}" timestamp
	local log="${2:-}"

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$log" ]] && { echo "LogFile '$log' Not Found!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi
	echo "$timestamp :: $USERNAME - $msg" >>"$log"
}
# ------------------------------------------------------------------
# install::log::redis
# ------------------------------------------------------------------
install::log::redis()
{
	local msg="${1:-}" timestamp
	local key="${2:-}"

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$log" ]] && { echo "LogFile '$log' Not Found!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi

	redis-cli
	# echo "$timestamp :: $USERNAME - $msg" >>"$log"
}
# ------------------------------------------------------------------
# install::redis::passGET
# ------------------------------------------------------------------
install::redis::passGET()
{
	sed -n -e '/^requirepass.*/p' /etc/redis/redis.conf | awk '{print $2}'
}
# ==================================================================
# MAIN
# ==================================================================
clear
install::checkShell
install::checkRoot

install::init "$logFile"

if [[ "$#" == 0 ]]; then set -- "all"; fi

while true
do
	case "$1" in
		all)
			install::install "$logFile"
			exit 0
			;;
		bin)
			install::loadSource bin.sh "$logFile" -i
			;;
		rmBin|binRemove)
			install::loadSource bin.sh "$logFile" -r
			;;
		config)
			install::loadSource config.sh "$logFile" -i
			;;
		rmConfig|configRemove)
			install::loadSource config.sh "$logFile" -r
			;;
		dotfiles)
			install::loadSource dotfiles.sh "$logFile" -i
			;;
		rmDotfiles|dotfilesRemove)
			install::loadSource dotfiles.sh "$logFile" -r
			;;
		init)
			install::init
			;;
		swarm)
			install::loadSource swarm.sh "$logFile" -i
			;;
		rmSwarm|swarmRemove)
			install::loadSource swarm.sh "$logFile" -r
			;;
		node)
			install::loadSource node.sh "$logFile" -i -c
			;;
		*)
			echo "Invalid Option '$1'"
			exit 1
			;;
	esac
	shift
done

install::report "$logFile"
