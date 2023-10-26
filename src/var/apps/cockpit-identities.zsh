#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/cockpit-identities
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cockpit-identities
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
cockpit-identities::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-IDENTITIES"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	wget -O "$USERDIR"/downloads/cockpit_identities-setup.zsh https://repo.45drives.com/setup

	bash "$USERDIR"/downloads/cockpit_identities-setup.zsh

	sudo apt update

	sudo apt install -y cockpit-identities

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-identities::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-IDENTITIES"
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
cockpit-identities::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-IDENTITIES"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove cockpit-identities

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
