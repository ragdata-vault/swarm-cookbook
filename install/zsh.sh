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

		while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR" maxdepth 1 -name ".bash*" -type f)

		mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."

		chown "$USERNAME":"$USERNAME" "$USERDIR"/.bash_archive

		sudo apt install -y zsh

		chsh -s "$(which zsh)" "$USERNAME"

		zsh

		if [[ ! -f "$USERDIR"/.zshrc ]]; then touch "$USERDIR"/.zshrc; fi

		echo "bash; sudo .$REPO/install.sh zsh cont;" >> "$USERDIR"/.zshrc

		sudo reboot
	elif [[ "${1,,}" == "cont" ]]; then
		# remove line in .zshrc written before reboot
		cp "$USERDIR"/.zshrc "$USERDIR"/.zshrc.copy
		rm -f "$USERDIR"/.zshrc
		head -n -1 "$USERDIR"/.zshrc.copy > "$USERDIR"/.zshrc

		if [[ ! -d "$XDG_DOWNLOAD_DIR" ]]; then mkdir -p "$XDG_DOWNLOAD_DIR"; fi

		chown "$USERNAME":"$USERNAME" "$XDG_DOWNLOAD_DIR"

		# install oh-my-zsh
		sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O "$XDG_DOWNLOAD_DIR"/install-oh-my-zsh.sh)"
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

	echo

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

	echo

	echo
	echo "DONE!"
	echo
}
