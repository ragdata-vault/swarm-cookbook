#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/cockpit-cloudflared
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/cockpit-cloudflared
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
cockpit-cloudflared::install()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-CLOUDFLARED"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	wget -O "$USERDIR"/downloads/cockpit-cloudflared-v0.0.2-1.fc38.noarch.rpm https://github.com/spotsnel/cockpit-cloudflared/releases/download/v0.0.2/cockpit-cloudflared-v0.0.2-1.fc38.noarch.rpm

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-cloudflared::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-CLOUDFLARED"
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
cockpit-cloudflared::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-CLOUDFLARED"
	echo "===================================================================="
	echo

	rpm -e cockpit-cloudflared

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
