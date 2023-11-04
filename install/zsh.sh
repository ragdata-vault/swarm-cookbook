#!/usr/bin/env bash
# shellcheck disable=SC2155
# ==================================================================
# install/zsh
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/zsh
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# HELPER FUNCTIONS
# ==================================================================

# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
zsh::installed() { return 0; }
#
# INSTALL FUNCTION
#
zsh::install()
{
	if [[ -z "$USERNAME" ]]; then
		echo "ERROR :: 'USERNAME' Undefined!"
		exit 1
	fi

	echo
	echo "===================================================================="
	echo "INSTALLING :: ZSH"
	echo "===================================================================="
	echo

	if [[ -z "$1" ]]; then
		sudo apt update && sudo apt upgrade -y

		mkdir -p "$USERDIR"/.bash_archive

		while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR" -maxdepth 1 -name ".bash*" -type f)

		mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."

		chown "$USERNAME":"$USERNAME" "$USERDIR"/.bash_archive

		sudo apt install -y zsh

		sudo chsh -s "$(which zsh)" "$USERNAME"

		echo
		echo "===================================================================="
		echo "ZSH INSTALLED!"
		echo "===================================================================="
		echo
		echo "To configure, type 'zsh'"
		echo
		echo "Then, to install Oh-My-ZSH, type: 'sudo ./install.sh zsh cont'"
		echo
		echo "Finally, if you'd like to install the PowerLevel10K theme (if you also installed Oh-My-ZSH), type:"
		echo
		echo "'sudo ./install.sh zsh-p10k'"

	elif [[ "${1,,}" == "cont" ]]; then
		# remove line in .zshrc written before reboot
		cp "$USERDIR"/.zshrc "$USERDIR"/.zshrc.copy
		rm -f "$USERDIR"/.zshrc
		head -n -1 "$USERDIR"/.zshrc.copy > "$USERDIR"/.zshrc

		if [[ ! -d "$XDG_DOWNLOAD_DIR" ]]; then mkdir -p "$XDG_DOWNLOAD_DIR"; fi

		chown "$USERNAME":"$USERNAME" "$XDG_DOWNLOAD_DIR"

		# install oh-my-zsh
		wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O "$XDG_DOWNLOAD_DIR/install-oh-my-zsh.sh"
		chmod +x "$XDG_DOWNLOAD_DIR/install-oh-my-zsh.sh"
		chown "$USERNAME":"$USERNAME" "$XDG_DOWNLOAD_DIR/install-oh-my-zsh.sh"

		echo
		echo "===================================================================="
		echo "OH-MY-ZSH DOWNLOADED!"
		echo "===================================================================="
		echo
		echo "To install, type 'cd $XDG_DOWNLOAD_DIR; ./install-oh-my-zsh.sh'"

	fi

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
zsh::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: ZSH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
zsh::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: ZSH"
	echo "===================================================================="
	echo

	sudo chsh -s "$(which bash)" "$USERNAME"

	while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR/.bash_archive" -maxdepth 1 -name ".bash*" -type f)

	if [[ -f "$USERDIR/.bash_archive/.profile" ]]; then mv "$USERDIR/.bash_archive/.profile" "$USERDIR/."; fi

	sudo apt purge -y --autoremove zsh

	echo
	echo "===================================================================="
	echo "ZSH REMOVED!"
	echo "===================================================================="
	echo
	echo "To switch bach to bash (if you haven't already), type 'bash'"

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
zsh::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: ZSH"
	echo "===================================================================="
	echo

	local rv

	if [[ -n "$ZSH_VERSION" ]]; then echo "ZSH WORKING OK!"; rv=0; else echo "ZSH NOT RESPONDING!"; rv=1; fi

	echo
	echo "DONE!"
	echo

	return "$rv"
}
