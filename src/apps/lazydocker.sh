# ==================================================================
# src/apps/lazydocker
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/lazydocker
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
# HELP FUNCTION
#
lazydocker::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}LAZYDOCKER HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
lazydocker::requires() { echo; }
#
# INSTALLED FUNCTION
#
lazydocker::installed() { command -v lazydocker > /dev/null; }
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

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	cd "$XDG_DOWNLOAD_DIR" || return 1

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
