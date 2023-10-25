#!/usr/bin/env zsh
# shellcheck disable=SC2164
# ==================================================================
# src/var/apps/cockpit-file-sharing
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cockpit-file-sharing
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
cockpit-file-sharing::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-FILE-SHARING"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	wget -O "$USERDIR"/downloads/cockpit-file-sharing_3.2.9_generic.zip https://github.com/45Drives/cockpit-file-sharing/releases/download/v3.2.9/cockpit-file-sharing_3.2.9_generic.zip

	unzip "$USERDIR"/downloads/cockpit-file-sharing_3.2.9_generic.zip

	cd "$USERDIR"/downloads/cockpit-file-sharing_3.2.9_generic || return 1

	# no need to 'make' this one first - it comes pre-built
	make install

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-file-sharing::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-FILE-SHARING"
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
cockpit-file-sharing::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-FILE-SHARING"
	echo "===================================================================="
	echo

	rm -f /usr/local/bin/cockpit-file-sharing		# (???)

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
