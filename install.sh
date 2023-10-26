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
if [[ "${1:l}" == "logfile" ]]; then declare -gx logFile="${2:-}"; shift 2; else declare -gx logFile="$(mktemp -t INSTALL-XXXXXX)"; fi
declare -gx SOURCE_DIRS=("$REPO/src/apps" "$REPO/install")
declare -gx USERNAME="${SUDO_USER:-$(whoami)}"
# ==================================================================
# DEPENDENCIES
# ==================================================================
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
if ! typeset -f historyStats > /dev/null; then loadLib common.zsh; fi
if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
chown "$USERNAME":"$USERNAME" "$REPO"/.env
source "$REPO"/.env
# ==================================================================
# FUNCTIONS
# ==================================================================
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

	checkPkg "jq" "JQ"
	checkPkg "redis" "Redis"
	checkPkg "dialog" "Dialog"

	echo
	echo "SYSTEM INITIALIZATION - DONE!"
	echo "=================================================================="
	echo
}
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

	loadSource config.sh -i
	loadSource dotfiles.sh -i
	loadSource zsh-plugins.sh -i
	loadSource bin.sh -i
	loadSource lib.sh -i
	loadSource swarm.sh -i
	loadSource cron-updates.sh -i

	echo
	echo "FULL INSTALLATION - DONE!"
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
	echo
	echo -e "\t (V)iew Logs"
	echo -e "\t (R)eboot"
	echo -e "\t (Q)uit"
	echo

	read -rs -k 1 resp

	resp="${resp:l}"

	case "$resp" in
		v)
			echo
			echo "===================================================================="
			echo "CONTENT OF LOGFILE '$logFile'"
			echo "===================================================================="
			echo
			sudo cat "$logFile"
			echo
			echo "DONE!"
			echo
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
# ==================================================================
# MAIN
# ==================================================================
clear
checkShell
#checkRoot

install::init

if [[ "$#" == 0 ]]; then set -- "all"; fi

while [[ "$#" -gt 0 ]]
do
	case "$1" in
		all)
			install::install
			;;
		bin)
			loadSource bin.sh -i
			;;
		rmBin|binRemove)
			loadSource bin.sh -r
			;;
		config)
			loadSource config.sh -i
			;;
		rmConfig|configRemove)
			loadSource config.sh -r
			;;
		dotfiles)
			loadSource dotfiles.sh -i
			;;
		rmDotfiles|dotfilesRemove)
			loadSource dotfiles.sh -r
			;;
		init)
			install::init
			;;
		lib)
			loadSource lib.sh -i
			;;
		rmLib|libRemove)
			loadSource lib.sh -r
			;;
		swarm)
			loadSource swarm.sh -i
			;;
		rmSwarm|swarmRemove)
			loadSource swarm.sh -r
			;;
		node)
			loadSource node.sh -i -c
			;;
		zsh)
			sudo bash "$REPO"/install/zsh.sh "${@:2}"
			;;
		plugins)
			loadSource zsh-plugins.sh -i
			;;
	esac
	shift
done

install::report
