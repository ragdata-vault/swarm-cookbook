# ==================================================================
# src/apps/cockpit-headscale
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-headscale
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
cockpit-headscale::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-HEADSCALE"
	echo "===================================================================="
	echo

	[[ ! -d "$USERDIR"/downloads ]] && mkdir -p "$USERDIR"/downloads

	wget -O "$USERDIR"/downloads/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm https://github.com/spotsnel/cockpit-headscale/releases/download/v0.0.1/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm

	rpm -ivh "$USERDIR"/downloads/cockpit-headscale-v0.0.1-1.fc38.noarch.rpm

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-headscale::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-HEADSCALE"
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
cockpit-headscale::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-HEADSCALE"
	echo "===================================================================="
	echo

	rpm -e cockpit-headscale

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
