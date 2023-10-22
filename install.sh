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
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ -z "$REPO" ]]; then export REPO="$(dirname "$(realpath "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")")"; fi
if [[ ! -f .env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
source "$REPO"/.env
chown "$USERNAME":"$USERNAME" "$REPO"/.env
# ==================================================================
# FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# install::bin
# ------------------------------------------------------------------
install::bin()
{
	local source logFile

	logFile="$(mktemp -t BIN-XXXXXX)"

	echo
	echo "=================================================================="
	echo "INSTALLING :: BIN FILES"
	echo "=================================================================="
	echo

	source="$REPO"/src/bin

	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t /usr/local/bin "$file"
		if [[ $? -ne 0 ]]; then
			install::log "Possible problem installing '$file' to /usr/local/bin - exit code $?" "$logFile"
		else
			install::log "Installed '$file' to /usr/local/bin OK!" "$logFile"
		fi
	done < <(find "$source" -type f)

	echo
	echo "BIN FILES - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::config
# ------------------------------------------------------------------
install::config()
{
	local flag="${1:-}"
	local source logFile refresh=0

	logFile="$(mktemp -t CFG-XXXXXX)"

	if [[ -n "$flag" ]] && [[ "${flag:l}" == "new" ]]; then refresh=1; install::log "Config Refresh Flag Detected!" "$logFile"; fi

	echo
	echo "=================================================================="
	echo "INSTALLING :: CONFIG FILES"
	echo "=================================================================="
	echo

	install::log "Installing distribution versions of config files" "$logFile"

	source="$REPO"

	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.env.dist
	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.node.dist

	install::log "Installing config files in '$SWARMDIR', if available" "$logFile"

	if [[ ! -f "$SWARMDIR"/.env ]] || [[ "$refresh" == 1 ]]; then install -v -m 0755 -C -T "$source"/.env.dist "$SWARMDIR"/.env; fi
	if [[ ! -f "$SWARMDIR"/.node ]] || [[ "$refresh" == 1 ]]; then install -v -m 0755 -C -T "$source"/.node.dist "$SWARMDIR"/.node; fi

	chown -R "$USERNAME":"$USERNAME" "$SWARMDIR"

	echo
	echo "CONFIG FILES - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::dotfiles
# ------------------------------------------------------------------
install::dotfiles()
{
	local source logFile fileDir stub

	logFile="$(mktemp -t DOT-XXXXXX)"

	echo
	echo "=================================================================="
	echo "INSTALLING :: DOTFILES"
	echo "=================================================================="
	echo

	install::log "Installing ZSH Profile Files to '$USERDIR'" "$logFile"

	source="$REPO"/src/.dotfiles
	install -v -C -m 0644 -D -t "$USERDIR" "$source"/.zshenv
	install -v -C -m 0644 -D -t "$USERDIR" "$source"/.zprofile
	install -v -C -m 0644 -D -t "$USERDIR" "$source"/.zshrc
	install -v -C -m 0644 -D -t "$USERDIR" "$source"/.zlogin
	install -v -C -m 0644 -D -t "$USERDIR" "$source"/.zlogout

	install::log "Installing ZSH Loaders / Utility Files to '$ZSHDIR'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_aliases
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_completion
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_functions
	if [[ ! -f "$source"/.zsh_ssh ]]; then install -v -C -m 0644 -T "$source"/.zsh_ssh.dist "$ZSHDIR"/.zsh_ssh;
	else install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_ssh; fi
	if [[ ! -f "$source"/.zsh_ssh ]]; then install -v -C -m 0644 -T "$source"/.zsh_ssh.dist "$ZSHDIR"/.zsh_ware;
	else install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_ware; fi

	install::log "Installing ZSH Aliases to '$ZSHDIR/aliases'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/aliases
	while IFS= read -r file
	do
		install -v -C -m 0644 -D -t "$ZSHDIR"/aliases "$file"
	done < <(find "$source" -type f)

	install::log "Installing ZSH Completion Files to '$ZSHDIR/completion'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/completion
	install -v -C -m 0644 -T "$source"/git-completion.bash "$ZSHDIR"/completion/git-completion.bash
	install -v -C -m 0644 -T "$source"/git-completion.zsh "$ZSHDIR"/completion/_git

	install::log "Installing ZSH Autoload Functions to '$ZSHDIR/functions'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/functions
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		stub="${fileDir:$len}"
		install -v -C -m 0644 -D -t "$ZSHDIR/functions${stub}" "$file"
	done < <(find "$source" -type f)

	install::log "Installing ZSH Includes to '$ZSHDIR/includes'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/includes
	while IFS= read -r file
	do
		install -v -C -m 0644 -D -t "$ZSHDIR/includes" "$file"
	done < <(find "$source" -type f)

	echo
	echo "DOTFILES - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::install
# ------------------------------------------------------------------
install::install()
{
	local type="${1:-}"
	local cont="${2:-}"
	local source logFile

	logFile="$(mktemp -t FULL-XXXXXX)"

	echo
	echo "=================================================================="
	echo "FULL INSTALLATION"
	echo "=================================================================="
	echo

	install::config
	install::dotfiles
	install::bin
	install::swarm

	echo
	echo "FULL INSTALLATION - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::init
# ------------------------------------------------------------------
install::init()
{
	local logFile
	local -A PACKAGES

	logFile="$(mktemp -t INIT-XXXXXX)"

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
# install::swarm
# ------------------------------------------------------------------
install::swarm()
{
	local source logFile

	logFile="$(mktemp SWARM-XXXXXX)"

	echo
	echo "=================================================================="
	echo "INSTALLING :: SWARM FILES"
	echo "=================================================================="
	echo

	install::log "Installing App Installer Files to '$SWARMDIR/apps'" "$logFile"

	source="$REPO"/src/var/apps
	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t "$SWARMDIR"/apps "$file"
	done < <(find "$source" -type f)

	install::log "Installing Script Files to '$SWARMDIR/scripts'" "$logFile"

	source="$REPO"/src/var/scripts
	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t "$SWARMDIR"/scripts "$file"
	done < <(find "$source" -type f)

	install::log "Installing Stack Files to '$SWARMDIR/stacks'" "$logFile"

	source="$REPO"/src/var/stacks
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		fileName="${file##*/}"
		stub="${fileDir:$len}"
		[[ "$fileName" == ".stack" ]] && mode="0755" || mode="0644"
		if [[ "$fileName" == ".env.dist" ]]; then
			fullName="$SWARMDIR"/stacks${stub}/.env
			if [[ -f "$fullName" ]]; then
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$fullName"
			else
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
			fi
		else
			install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
		fi
	done < <(find "$source" -type f)

	echo
	echo "SWARM FILES - DONE!"
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
# install::loadSource
# ------------------------------------------------------------------
install::loadSource()
{
	local app="${1:-}"
	local logFile="${2:-}"
	local options dir fileName fullPath filePath pathName
	local -A FILEOPTS

	if [[ -z "$app" ]] || [[ -z "$logFile" ]]; then install::log "Missing Argument(s)!" "$logFile"; exit 1; fi

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
				install::log "loadSource :: Invalid Option '$1'" "$logFile"
				exit 1
				;;
		esac
		shift
	done

	if [[ -f "$app" ]]; then
		fullPath="$app"
	else
		if [[ $DEBUG -eq 1 ]]; then install::log "Finding '$app'" "$logFile"; fi
		if [[ ! $app = *.* ]]; then app="$app".zsh; fi
		if [[ ! $app = */* ]]; then fullPath="$REPO"/src/var/apps/"$app"; fi
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
		eval "$fileName::install"
		return $?
	elif [[ "${FILEOPTS[remove]}" -eq 1 ]]; then
		install::log "Uninstalling '$fileName'" "$logFile"
		eval "$fileName::remove"
		return $?
	fi
	# CONFIGURE
	if [[ "${FILEOPTS[config]}" -eq 1 ]]; then
		install::log "Configuring '$fileName'" "$logFile"
		eval "$fileName::config"
		return $?
	fi
	# TEST
	if [[ "${FILEOPTS[test]}" -eq 1 ]]; then
		install::log "Testing '$fileName'" "$logFile"
		eval "$fileName::test"
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
	local key="${2:-}"zZ

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$log" ]] && { echo "LogFile '$log' Not Found!"; exit 1; }

	if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi
	echo "$timestamp :: $USERNAME - $msg" >>"$log"
}
# ==================================================================
# MAIN
# ==================================================================
clear
install::checkShell
install::checkRoot

install::init

if [[ "$#" == 0 ]]; then set -- "all"; fi

while true
do
	case "$1" in
		all)
			install::install "$@"
			exit 0
			;;
		bin)
			install::bin
			;;
		config)
			install::config
			;;
		configReset)
			install::config new
			;;
		dotfiles)
			install::dotfiles
			;;
		init)
			install::init
			;;
		swarm)
			install::swarm
			;;
		*)
			echo "Invalid Option '$1'"
			exit 1
			;;
	esac
	shift
done
