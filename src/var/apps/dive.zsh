#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/dive
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/dive
# Author:       Ragdata
# Date:         09/10/2023
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
dive::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}" DIVE_VERSION

	echo
	echo "===================================================================="
	echo "INSTALLING DIVE"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	# get latest version tag
	DIVE_VERSION=$(curl -s "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
	# download latest Debian package
	wget -O "$USERDIR"/downloads/dive.deb https://github.com/wagoodman/dive/releases/latest/download/dive_${DIVE_VERSION}_linux_amd64.deb

	sudo apt install -y "$USERDIR"/downloads/dive.deb

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dive::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DIVE"
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
dive::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DIVE"
	echo "===================================================================="
	echo

	sudo apt purge -y dive

	echo
	echo "DONE!"
	echo
}
