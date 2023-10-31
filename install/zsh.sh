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
if [[ -z "$REPO" ]]; then export REPO="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"; fi
if [[ ! -f "$REPO"/.env ]]; then cp "$REPO"/.env.dist "$REPO"/.env; fi
# include environment file
source "$REPO"/.env
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
	echo
	echo "===================================================================="
	echo "INSTALLING :: ZSH"
	echo "===================================================================="
	echo

	if [[ -z "$1" ]]; then
		sudo apt update && sudo apt upgrade -y

		mkdir -p "$USERDIR"/.bash_archive

		while IFS= read -r file; do filename="${file##*/}"; mv "$file" "$USERDIR"/.bash_archive/"$filename"; done < <(find "$USERDIR" -maxdepth 1 -name ".bash*" -type f)

		mv "$USERDIR/.bash*" "$USERDIR/.bash_archive/."
		mv "$USERDIR/.profile" "$USERDIR/.bash_archive/."

		sudo apt install -y zsh

		sudo chsh -s "$(which zsh)" "$USERNAME"

		if [[ -f "$USERDIR"/.zshrc ]]; then
			echo "sudo bash $REPO/install/zsh.sh cont" >> "$USERDIR"/.zshrc
		else
			echo "sudo bash $REPO/install/zsh.sh cont" > "$USERDIR"/.zshrc
		fi

		sudo reboot
	elif [[ "${1,,}" == "cont" ]]; then
		# remove line in .zshrc written before reboot
		tail -n 1 "$USERDIR/.zshrc" | wc -c xargs -I {} truncate "$USERDIR/.zshrc" -s -{}
		# install zsh plugins
		sudo ./"$REPO"/install.sh plugins
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
#
# REPORT FUNCTION
#
zsh::report()
{
	echo
	echo "===================================================================="
	echo "REPORTING :: ZSH"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
# ==================================================================
# MAIN
# ==================================================================
clear

zsh::install "$@"
zsh::report
