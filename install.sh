#!/usr/bin/env bash
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
# if script is called with 'debug' as an argument, then set debug mode
if [[ "${1,,}" == "debug" ]] || [[ "$DEBUG" == 1 ]]; then shift; export DEBUG=1; set -- "${@}"; set -axeET; else export DEBUG=0; set -aeET; fi
# if script is called with 'verbose' as an argument, then unset verbose mode
if [[ "${1,,}" == "verbose" ]] || [[ "$LOG_VERBOSE" == 0 ]]; then shift; export LOG_VERBOSE=0; else export LOG_VERBOSE=1; fi
# ==================================================================
# VARIABLES
# ==================================================================
# define REPO
if [[ -z "$REPO" ]]; then export REPO="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"; fi
# define SOURCE_DIRS
export SOURCE_DIRS=("$REPO/src/apps" "$REPO/install")
# define USERNAME
export USERNAME="${SUDO_USER:-$(whoami)}"
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! grep -q 'function' <<< "$(type loadLib 2> /dev/null)"; then
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
# load common.zsh library
if ! grep -q 'function' <<< "$(type historyStats 2> /dev/null)"; then loadLib common.zsh; fi
## create .env, if not exists
#if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
## create .node, if not exists
#if [[ ! -f "$REPO"/.node ]]; then cp "$REPO"/.node.dist "$REPO"/.node; fi
## set file ownership
#chown "$USERNAME":"$USERNAME" "$REPO"/.env "$REPO"/.node
## load .env & .node
#source "$REPO"/.env; source "$REPO"/.node;
# initialize log
if [[ "${1,,}" == "logfile" ]]; then export logFile="${2:-}"; shift 2; else log::init; fi
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
	loadSource cron-updates.sh -i
	loadSource dotfiles.sh -i
	loadSource zsh-plugins.sh -i
	loadSource bin.sh -i
	loadSource lib.sh -i
	loadSource swarm.sh -i

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

	resp="${resp,,}"

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
