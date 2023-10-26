#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/cockpit-certificates
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cockpit-certificates
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
cockpit-certificates::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-CERTIFICATES"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	sudo apt install -y certmonger

	git clone git@github.com:skobyda/cockpit-certificates "$USERDIR"/downloads/cockpit-certificates

	cd "$USERDIR"/downloads/cockpit-certificates || return 1

	make

	export NODE_ENV=production

	make install

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-certificates::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-CERTIFICATES"
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
cockpit-certificates::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-CERTIFICATES"
	echo "===================================================================="
	echo

	systemctl restart cockpit.socket

	sudo apt purge -y cockpit-certificates

	echo
	echo "DONE!"
	echo
}
