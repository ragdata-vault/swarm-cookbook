# ==================================================================
# src/apps/dive
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/dive
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
# HELP FUNCTION
#
dive::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DIVE HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
dive::requires() { echo; }
#
# INSTALLED FUNCTION
#
dive::installed() { if command -v dive > /dev/null; then return 0; else return 1; fi }
#
# INSTALL FUNCTION
#
dive::install()
{
	local DIVE_VERSION

	echo
	echo "===================================================================="
	echo "INSTALLING DIVE"
	echo "===================================================================="
	echo

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	# get latest version tag
	DIVE_VERSION=$(curl -s "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
	# download latest Debian package
	wget -O "$HOME"/downloads/dive.deb https://github.com/wagoodman/dive/releases/latest/download/dive_${DIVE_VERSION}_linux_amd64.deb

	sudo apt install -y "$HOME"/downloads/dive.deb

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

	sudo apt purge -y --autoremove dive

	echo
	echo "DONE!"
	echo
}
