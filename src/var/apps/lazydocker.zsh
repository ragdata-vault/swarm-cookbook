#!/usr/bin/env zsh
#
# ==================================================================
# src/var/apps/lazydocker
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/lazydocker
# Author:       Ragdata
# Date:         25/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALL FUNCTION
#
lazydocker::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING LAZYDOCKER"
	echo "===================================================================="
	echo

	export DIR=/usr/local/bin

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	cd "$HOME"/downloads || return 1

	wget https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.zsh

	chmod 0755 install_update_linux.zsh

	sudo ./install_update_linux.zsh

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
lazydocker::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING LAZYDOCKER"
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
lazydocker::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING LAZYDOCKER"
	echo "===================================================================="
	echo

	rm -f /usr/local/bin/lazydocker

	echo
	echo "DONE!"
	echo
}
