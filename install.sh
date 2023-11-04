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
# HELPER FUNCTIONS
# ==================================================================
if [[ "${SHELL##*/}" == 'bash' ]]; then
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
	# configGET
	# ------------------------------------------------------------------
	configGET()
	{
		local value
		local key="${1:-}"
		local field="${2:-}"

		value="$(redis-cli HGET "$key" "$field")"

		printf '%s' "$value"
	}
	# ------------------------------------------------------------------
	# configSET
	# ------------------------------------------------------------------
	configSET()
	{
		local key="${1:-}"
		local field="${2:-}"
		local value="${3:-}"

		if grep -q "$field" "$SWARMDIR"/.node; then
			sed -i "/^${field}.*/c\\${field}=${value}" "$SWARMDIR"/.node
		else
			echo "${field}=${value}" >> "$SWARMDIR"/.node
		fi

		redis-cli HSET "$key" "$field" "$value" > /dev/null
	}
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
	# getRepo
	# ------------------------------------------------------------------
	getRepo()
	{
		if [[ -n "$2" ]]; then git clone git@github.com:"${1:-}" "${2:-}";
		else git clone git@github.com:"${1:-}"; fi
	}
	# ------------------------------------------------------------------
	# loadLib
	# ------------------------------------------------------------------
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

		FILEOPTS[help]=0
		FILEOPTS[requires]=0
		FILEOPTS[installed]=0
		FILEOPTS[install]=0
		FILEOPTS[config]=0
		FILEOPTS[remove]=0
		FILEOPTS[test]=0

		options=$(getopt -o "hRcdirt" -a -- "$@")

		eval set -- "$options"

		while true
		do
			case "$1" in
				-h) FILEOPTS[help]=1;;
				-R) FILEOPTS[requires]=1;;
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
			if [[ ! "$app" = *.* ]]; then thisFile="$app".sh; else thisFile="$app"; fi
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
			eval "$fileName::installed $*"
			return $?
		fi
		# INSTALL & REMOVE
		if [[ "${FILEOPTS[install]}" -eq 1 ]]; then
			log::file "Installing '$fileName'"
			eval "$fileName::install $*"
			return $?
		elif [[ "${FILEOPTS[remove]}" -eq 1 ]]; then
			log::file "Uninstalling '$fileName'"
			eval "$fileName::remove $*"
			return $?
		fi
		# CONFIGURE
		if [[ "${FILEOPTS[config]}" -eq 1 ]]; then
			log::file "Configuring '$fileName'"
			eval "$fileName::config $*"
			return $?
		fi
		# TEST
		if [[ "${FILEOPTS[test]}" -eq 1 ]]; then
			log::file "Testing '$fileName'"
			eval "$fileName::test $*"
			return $?
		fi
	}
	# ------------------------------------------------------------------
	# log::init
	# ------------------------------------------------------------------
	log::init()
	{
		local file="${1:-}"

		if [[ ! -d "$LOGDIR" ]]; then sudo mkdir -p "$LOGDIR"; fi

		if [[ -z "$file" ]]; then file=ZSH-"$(logTime)"; fi

		export logFile="$LOGDIR/$file"

		sudo touch "$logFile"

		log::file "LogFile Initialized"
	}
	# ------------------------------------------------------------------
	# log::file
	# ------------------------------------------------------------------
	log::file()
	{
		local msg="${1:-}" timestamp

		timestamp="$(logStamp)"

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

		timestamp="$(logStamp)"

		[[ -z "$REDISCLI_AUTH" ]] && { echo "Redis Authentication Missing!"; exit 1; }

		if [[ "$LOG_VERBOSE" -eq 1 ]]; then echo "$msg"; fi

		redis-cli "$logFile" "$key" "$val" > /dev/null
	}
	# ------------------------------------------------------------------
	# logStamp
	# ------------------------------------------------------------------
	logStamp()
	{
		local dtg="$(date -u +'%Y-%m-%dT%H:%M:%S.%3N%z')";

		printf '%s' "$dtg"
	}
	# ------------------------------------------------------------------
	# logTime
	# ------------------------------------------------------------------
	logTime()
	{
		local dtg="$(date -u +'%y%m%dT%H%M%S.%3N')"

		printf '%s' "$dtg"
	}
	# ------------------------------------------------------------------
	# redis::passGET
	# ------------------------------------------------------------------
	redis::passGET() { sudo sed -n -e '/^requirepass.*/p' /etc/redis/redis.conf | awk '{print $2}'; }
else
	# ------------------------------------------------------------------
	# loadLib
	# ------------------------------------------------------------------
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
if [[ "${SHELL##*/}" == 'zsh' ]]; then
	if ! grep -q 'function' <<< "$(type historyStats 2> /dev/null)"; then loadLib common.zsh; fi
fi
# create .env, if not exists
if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
# set file ownership
chown "$USERNAME":"$USERNAME" "$REPO"/.env
# load .env
source "$REPO"/.env;
# initialize log
if [[ "${1,,}" == "logfile" ]]; then export logFile="${2:-}"; shift 2; else log::init INSTALL-"$(logTime)"; fi
# ==================================================================
# INSTALL FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# install::init
# ------------------------------------------------------------------
install::init()
{
	if [[ -f "$USERDIR/.local/.node-init" ]]; then return 0; fi

	echo
	echo "=================================================================="
	echo "SYSTEM INITIALIZATION"
	echo "=================================================================="
	echo

	checkPkg "jq" "JQ"
	checkPkg "redis" "Redis"
	loadSource redis -c
	checkPkg "dialog" "Dialog"

	if [[ ! -d "$USERDIR/.local" ]]; then mkdir -p "$USERDIR/.local"; fi
	touch "$USERDIR/.local/.node-init"

	echo
	echo "SYSTEM INITIALIZATION - DONE!"
	echo "=================================================================="
	echo
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

	read -rs -n 1 resp

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
#checkShell
#checkRoot

install::init

if [[ "$#" == 0 ]]; then set -- "all"; fi

while [[ "$#" -gt 0 ]]
do
	case "$1" in
		zsh)
			loadSource zsh -i "${@:2}"
			;;
		configZSH|zshConfig)
			loadSource zsh -c
			;;
		rmZSH|zshRemove)
			loadSource zsh -r
			;;
		zsh-p10k)
			loadSource zsh-p10k -i
			;;
	esac
	shift
done

if [[ -n "$ZSH_RESTART" ]]; then
	exec zsh
else
	install::report
fi
