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
	if [[ -z "$USERNAME" ]]; then log::exit "ERROR :: 'USERNAME' Undefined!"; fi

	echo
	echo "===================================================================="
	echo "INSTALLING :: ZSH"
	echo "===================================================================="
	echo

	if [[ -z "$1" ]]; then
		sudo apt update && sudo apt upgrade -y

		mkdir -p "$HOME"/.bash_archive

		while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$HOME"/.bash_archive/"$filename"; done < <(find "$HOME" -maxdepth 1 -name ".bash*" -type f)

		mv "$HOME/.profile" "$HOME/.bash_archive/."

		chown "$USERNAME":"$USERNAME" "$HOME"/.bash_archive

		sudo apt install -y zsh

		#sudo chsh -s "$(which zsh)" "$USERNAME"

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
		echo
		echo "When you've finished installing everything and are ready to use zsh as your default shell, type:"
		echo
		echo "chsh -s $(which zsh) <username>"

	elif [[ "${1}" == "cont" ]]; then

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

	#sudo chsh -s "$(which bash)" "$USERNAME"

	while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$HOME"/.bash_archive/"$filename"; done < <(find "$HOME/.bash_archive" -maxdepth 1 -name ".bash*" -type f)

	if [[ -f "$HOME/.bash_archive/.profile" ]]; then mv "$HOME/.bash_archive/.profile" "$HOME/."; fi

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
