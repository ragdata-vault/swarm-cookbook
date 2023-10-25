#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2031,SC2034,SC2154,SC2155,SC2181,SC2260
# ==================================================================
# install.sh
# ==================================================================
# Swarm Cookbook Installer
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
if [[ -z "$LOG_VERBOSE" ]]; then declare -gx LOG_VERBOSE=0; fi
# if script is called with 'debug' as an argument, then set debug mode
if [[ "${1:l}" == "debug" ]] || [[ "$DEBUG" == 1 ]]; then shift; DEBUG=1; set -- "${@}"; set -axeET; else set -aeET; fi
if [[ "${1:l}" == "verbose" ]] || [[ "$LOG_VERBOSE" == 1 ]]; then shift; LOG_VERBOSE=1; else LOG_VERBOSE=0; fi
# ==================================================================
# VARIABLES
# ==================================================================
if [[ -z "$REPO" ]]; then export REPO="$(realpath "${0:h}")"; fi
declare -gx SOURCE_DIRS=("$REPO/src/var/apps" "$REPO/install")
declare -gx logFile="$(mktemp -t INSTALL-XXXXXX)"
declare -gx USERNAME="${SUDO_USER:-$(whoami)}"
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
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
	echo
	echo "=================================================================="
	echo "FULL INSTALLATION"
	echo "=================================================================="
	echo

	install::loadSource config.sh -i
	install::loadSource dotfiles.sh -i
	install::loadSource bin.sh -i
	install::loadSource swarm.sh -i

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
	echo
	echo "=================================================================="
	echo "SYSTEM INITIALIZATION"
	echo "=================================================================="
	echo

	install::checkPkg "jq" "JQ"
	install::checkPkg "redis" "Redis"
	install::checkPkg "dialog" "Dialog"

	echo
	echo "SYSTEM INITIALIZATION - DONE!"
	echo "=================================================================="
	echo
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
	local resp

	[[ -z "$logFile" ]] && { echo "No logFile passed for reporting!"; exit 1; }

	echo "The previous operation was logged and details are available to view"
	echo "Please select from the following options:"
	echo -e "\t (V)iew Logs"
	echo -e "\t (R)eboot"
	echo -e "\t (Q)uit"
	read -r -n 1 resp

	case "${resp:l}" in
		v)
			echo
			sudo cat "$logFile"
			exit 0
			;;
		r)
			reboot
			;;
		q)
			exit 0
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

	if [[ -z "$pkg" ]] || [[ -z "$name" ]]; then echo "Missing Argument(s)!"; exit 1; fi

	if install::loadSource "$pkg" -d; then
		install::log "Found '$name'"
	else
		install::loadSource "$pkg" -i
		if [ "$?" -ne 0 ]; then install::log "Failed installing '$name' - exiting ..."; exit 1; fi
	fi
}
# ------------------------------------------------------------------
# install::checkRoot
# ------------------------------------------------------------------
install::checkRoot()
{
	if [ $EUID -ne 0 ]; then
		echo "This script MUST be run as root!"
		exit 1
	fi
}
# ------------------------------------------------------------------
# install::checkShell
# ------------------------------------------------------------------
install::checkShell()
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
	local options dir fileName fullPath filePath pathName
	local -A FILEOPTS

	if [[ -z "$app" ]]; then echo "Missing Argument!"; exit 1; fi

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
				echo "loadSource :: Invalid Option '$1'"
				exit 1
				;;
		esac
		shift
	done

	if [[ -f "$app" ]]; then
		fullPath="$app"
	else
		if [[ $DEBUG -eq 1 ]]; then install::log "Finding '$app'"; fi
		if [[ ! "$app" = *.* ]]; then thisFile="$app".zsh; else thisFile="$app"; fi
		for dir in "${SOURCE_DIRS[@]}"
		do
			if [[ $DEBUG -eq 1 ]]; then install::log "Searching '$dir'"; fi
			if [[ -f "$dir/$thisFile" ]]; then fullPath="$dir/$thisFile"; break; fi
		done
	fi

	if [[ -z "$fullPath" ]] || [[ ! -f "$fullPath" ]]; then install::log "File '$app' Not Found!"; exit 1; fi

	source "$fullPath"

	# INSTALLED
	if [[ "${FILEOPTS[installed]}" -eq 1 ]]; then
		install::log "Checking if '$fileName' installed"
		eval "$fileName::installed"
		return $?
	fi
	# INSTALL & REMOVE
	if [[ "${FILEOPTS[install]}" -eq 1 ]]; then
		install::log "Installing '$fileName'"
		eval "$fileName::install $logFile"
		return $?
	elif [[ "${FILEOPTS[remove]}" -eq 1 ]]; then
		install::log "Uninstalling '$fileName'"
		eval "$fileName::remove $logFile"
		return $?
	fi
	# CONFIGURE
	if [[ "${FILEOPTS[config]}" -eq 1 ]]; then
		install::log "Configuring '$fileName'"
		eval "$fileName::config $logFile"
		return $?
	fi
	# TEST
	if [[ "${FILEOPTS[test]}" -eq 1 ]]; then
		install::log "Testing '$fileName'"
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

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$logFile" ]] && { echo "LogFile '$logFile' Not Found!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi
	echo "$timestamp :: $USERNAME - $msg" | sudo tee -a "$logFile" > /dev/null
}
# ------------------------------------------------------------------
# install::log::redis
# ------------------------------------------------------------------
install::log::redis()
{
	local msg="${1:-}" timestamp
	local key="${2:-}"

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$logFile" ]] && { echo "LogFile '$logFile' Not Found!"; exit 1; }

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
#install::checkRoot

install::init

if [[ "$#" == 0 ]]; then set -- "all"; fi

while [[ "$#" -gt 0 ]]
do
	case "$1" in
		all)
			install::install
			;;
		bin)
			install::loadSource bin.sh -i
			;;
		rmBin|binRemove)
			install::loadSource bin.sh -r
			;;
		config)
			install::loadSource config.sh -i
			;;
		rmConfig|configRemove)
			install::loadSource config.sh -r
			;;
		dotfiles)
			install::loadSource dotfiles.sh -i
			;;
		rmDotfiles|dotfilesRemove)
			install::loadSource dotfiles.sh -r
			;;
		init)
			install::init
			;;
		swarm)
			install::loadSource swarm.sh -i
			;;
		rmSwarm|swarmRemove)
			install::loadSource swarm.sh -r
			;;
		node)
			install::loadSource node.sh -i -c
			;;
	esac
	shift
done

install::report
