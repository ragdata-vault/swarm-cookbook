# ==================================================================
# src/apps/cockpit-tailscale
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/cockpit-tailscale
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
cockpit-tailscale::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING COCKPIT-TAILSCALE"
	echo "===================================================================="
	echo

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	wget -O "$HOME"/downloads/cockpit-tailscale-v0.0.6.6.gb7dbce5-1.el9.noarch.rpm https://github.com/spotsnel/cockpit-tailscale/releases/download/v0.0.6/cockpit-tailscale-v0.0.6.6.gb7dbce5-1.el9.noarch.rpm

	rpm -ivh "$HOME"/downloads/cockpit-tailscale-v0.0.6.6.gb7dbce5-1.el9.noarch.rpm

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
cockpit-tailscale::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING COCKPIT-TAILSCALE"
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
cockpit-tailscale::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING COCKPIT-TAILSCALE"
	echo "===================================================================="
	echo

	rpm -e cockpit-tailscale

	systemctl restart cockpit.socket

	echo
	echo "DONE!"
	echo
}
