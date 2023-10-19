#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2031,SC2034,SC2154,SC2155,SC2260
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
# get the username of the user executing the script
declare -gx USERNAME="${SUDO_USER:-$(whoami)}"
# set sudo-safe home directory
if [[ "$USERNAME" != "root" ]]; then
	declare -gx USERDIR=/home/"$USERNAME"
else
	declare -gx USERDIR=/root
fi
declare -gx SHELL_TYPE
SHELL_TYPE="$SHELL"
SHELL_TYPE="${SHELL_TYPE##*/}"
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ -z "$REPO" ]]; then REPO="${0:h}"; export "${REPO?}"; fi
if [[ ! -f .env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
source "$REPO"/.env
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

	source="$REPO"/src/var/cfg

	install -v -C -m 0755 -D -t "$SWARMDIR"/cfg "$source"/.env.dist
	install -v -C -m 0755 -D -t "$SWARMDIR"/cfg "$source"/.node.dist
	install -v -C -m 0755 -D -t "$SWARMDIR"/cfg "$source"/.paths.dist

	install::log "Installing config files in '$SWARMDIR/cfg', if available" "$logFile"

	if [[ ! -f "$SWARMDIR"/cfg/.env ]] || [[ "$refresh" == 1 ]]; then install -v -m 0755 -C -T "$source"/.env.dist "$SWARMDIR"/cfg/.env; fi
	if [[ ! -f "$SWARMDIR"/cfg/.node ]] || [[ "$refresh" == 1 ]]; then install -v -m 0755 -C -T "$source"/.node.dist "$SWARMDIR"/cfg/.node; fi
	if [[ ! -f "$SWARMDIR"/cfg/.paths ]] || [[ "$refresh" == 1 ]]; then install -v -m 0755 -C -T "$source"/.paths.dist "$SWARMDIR"/cfg/.paths; fi

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

	if [[ "$SHELL_TYPE" != "zsh" ]] || [[ -n "$cont" ]]; then
		install::zsh "$@"
	fi

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
# install::zsh
# ------------------------------------------------------------------
install::zsh()
{
	local script="${0}"
	local type="${1:-}"
	local cont="${2:-}"
	local source logFile

	if [[ -n "$cont" ]] && [[ "$cont" != "cont" ]]; then echo "Unexpected Argument in pos 2 '$2'!"; exit 1; fi

	logFile="$(mktemp -t ZSH-XXXXXX)"

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	if [[ -z "$cont" ]]; then
		echo
		echo "=================================================================="
		echo "INSTALL ZSH"
		echo "=================================================================="
		echo

		install::log "Update & Upgrade System" "$logFile"
		apt update && apt upgrade -y

		install::log "Archiving existing shell config" "$logFile"
		mkdir -p "$USERDIR/.bash_archive"
		mv "$USERDIR/.bash*" "$USERDIR/.bash_archive/."
		mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."

		install::log "Installing ZSH Shell" "$logFile"
		apt install -y zsh

		install::log "Set ZSH as default shell" "$logFile"
		chsh -s "$(which zsh)"

		install::log "Perform basic configuration of ZSH" "$logFile"
		launchctl setenv ZDOTDIR="$USERDIR"
		launchctl setenv ZSHDIR="$USERDIR"/.zsh

		# write a line to the user's .zshrc file which automatically executes this installation script again
		# when returning from system reboot with the same arguments it was called with originally.
		install::log "Writing restart command to $USERDIR/.zshrc" "$logFile"
		echo "zsh_install ${script} ${type} cont" >> "$USERDIR"/.zshrc

		install::log "Persist this logFile" "$logFile"
		install -b -C -m 0644 -T "$logFile" "$USERDIR"/install."$(date +"%Y%m%d%H%M%S")".log

		install::log "Rebooting ..." "$logFile"
		reboot
	else
		local -A PLUGINS_ESSENTIAL

		echo
		echo "=================================================================="
		echo "INSTALL ZSH (CONTINUED)"
		echo "=================================================================="
		echo

		install::log "Returning from reboot - remove exec command" "$logFile"
		tail -n 1 "$USERDIR/.zshrc" | wc -c xargs -I {} truncate "$USERDIR/.zshrc" -s -{}

		install::log "Installing Powerline Fonts" "$logFile"
		apt install -y fonts-powerline

		install::log "Installing Sheldon Plugin Manager" "$logFile"
		install -C -m 0755 -D -t /usr/local/bin "$REPO/src/var/zsh/sheldon"

		install::log "Initializing Sheldon Plugin Manager" "$logFile"
		sheldon init --shell "$SHELL_TYPE"

		install::log "Adding plugins for Oh-My-ZSH via Sheldon Plugin Manager:" "$logFile"
		# ----------------------------------------------------------
		# MUST-HAVE PLUGINS
		# ----------------------------------------------------------
		PLUGINS_ESSENTIAL=(
			["oh-my-zsh"]="ohmyzsh/ohmyzsh"
			["auto-suggestions"]="zsh-users/zsh-autosuggestions"
			["git"]="davidde/git"
			["sudo"]="hcgraf/zsh-sudo"
			["powerlevel10k"]="romkatv/powerlevel10k"
			["syntax-highlighting"]="zsh-users/zsh-syntax-highlighting"
		)
		PLUGINS_RECOMMENDED=(
			["git-aliases"]="mdumitru/git-aliases"
			["git-tree"]="dehlen/git-tree-zsh"
			["zsh-defer"]="romkatv/zsh-defer"
			["web-search"]="Anant-mishra1729/web-search"
			["docker-aliases"]="webyneter/docker-aliases"
			["docker-compose"]="sroze/docker-compose-zsh-plugin"
			["systemd"]="le0me55i/zsh-systemd"
			["enhancd"]="babarot/enhancd"
			["jq"]="reegnz/jq-zsh-plugin"
			["lazyload"]="qoomon/zsh-lazyload"
		)
		PLUGINS_OPTIONAL=(
			["copyzshell"]="rutchkiwi/copyzshell"
			["zsh-containers"]="redxtech/zsh-containers"
			["sysadmin-util"]="skx/sysadmin-util"
			["crash"]="molovo/crash"
			["czhttpd"]="jsks/czhttpd"
			["directory-history"]="tymm/zsh-directory-history"
			["blackbox"]="StackExchange/blackbox"
			["gpg-agent"]="axtl/gpg-agent.zsh"
			["gpg-crypt"]="Czocher/gpg-crypt"
			["dotfiles-plugin"]="vladmyr/dotfiles-plugin"
			["laravel"]="baliestri/laravel.plugin.zsh"
			["shell-plugins"]="gmatheu/shell-plugins"
			["ssh-connect"]="gko/ssh-connect"
			["zsh-plugin"]="paraqles/zsh-plugin-ssh"
			["wakatime"]="sobolevn/wakatime-zsh-plugin"
			["zshrc"]="freak2geek/zshrc"
			["zui"]="zdharma-continuum/zui"
		)

		for key in "${!PLUGINS_ESSENTIAL[@]}"
		do
			install::log "Add Plugin: $key" "$logFile"
			sheldon add "$key" --github "${PLUGINS_ESSENTIAL[$key]}"
		done
	fi

	echo
	echo "FULL INSTALLATION - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
}
# ------------------------------------------------------------------
# install::zshRemove
# ------------------------------------------------------------------
install::zshRemove()
{
	local source logFile SHELL_TYPE

	logFile="$(mktemp -t FULL-XXXXXX)"

	echo
	echo "=================================================================="
	echo "UNINSTALLING ZSH"
	echo "=================================================================="
	echo

	if [[ -d "$USERDIR/.zsh_archive" ]]; then rm -f "$USERDIR"/.zsh_archive/*; else mkdir -p "$USERDIR/.zsh_archive"; fi
	if [[ -d "$USERDIR/.oh-my-zsh" ]]; then rm -Rf "$USERDIR/.oh-my-zsh"; fi
	if [[ -d "$USERDIR/.zsh" ]]; then rm -Rf "$USERDIR/.zsh"; fi
	if [[ -f "$USERDIR/.zshrc*" ]]; then mv "$USERDIR/.zshrc*" "$USERDIR/.zsh_archive/.zshrc*"; fi
	if [[ -f "$USERDIR/.p10k.zsh" ]]; then mv "$USERDIR/.p10k*" "$USERDIR/.zsh_archive/.p10k*"; fi

	if [[ -d "$USERDIR/.bash_archive" ]]; then mv "$USERDIR/.bash_archive/*" "$USERDIR"/.; fi

	apt purge -y zsh

	chsh -s "$(which bash)"

	echo
	echo "UNINSTALLING ZSH - DONE!"
	echo "=================================================================="
	echo

	install::report "$logFile"
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
# install::uninstall
# ------------------------------------------------------------------
install::uninstall()
{
	cd /usr/local/bin || return 1
	rm -f app* stack* swarm*
	rm -Rf /"${ZSHDIR:?}"
	rm -Rf /"${SWARMDIR:?}"
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
# install::log
# ------------------------------------------------------------------
install::log()
{
	local msg="${1:-}" timestamp
	local log="${2:-}"

	timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

	[[ ! -f "$log" ]] && { echo "LogFile '$log' Not Found!"; exit 1; }

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

	echo "$timestamp :: $USERNAME - $msg" >>"$log"
}
# ==================================================================
# MAIN
# ==================================================================
install::checkShell
install::checkRoot

declare -a ARGS

if [[ "${#ARGS[@]}" == 0 ]]; then ARGS=("all"); fi

for arg in "${ARGS[@]}"
do
	case "${arg:l}" in
		all)
			install::install "$@"
			;;
		bin)
			install::bin
			;;
		config)
			install::config
			;;
		dotfiles)
			install::dotfiles
			;;
		new-config)
			install::config new
			;;
		rz)
			install::zshRemove
			;;
		swarm)
			install::swarm
			;;
		zsh)
			install::zsh "$@"
			;;
		*)
			echo "Invalid Option '$arg'"
			;;
	esac
done
