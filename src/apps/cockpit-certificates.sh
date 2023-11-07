# ==================================================================
# src/apps/cockpit-certificates
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-certificates
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
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-CERTIFICATES"
	echo "===================================================================="
	echo

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	sudo apt install -y certmonger

	git clone git@github.com:skobyda/cockpit-certificates "$HOME"/downloads/cockpit-certificates

	cd "$HOME"/downloads/cockpit-certificates || return 1

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

	sudo apt purge -y --autoremove cockpit-certificates

	echo
	echo "DONE!"
	echo
}
