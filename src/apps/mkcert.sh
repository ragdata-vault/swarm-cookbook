# ==================================================================
# src/apps/mkcert
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/mkcert
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
mkcert::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}MKCERT HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
mkcert::requires() { echo; }
#
# INSTALLED FUNCTION
#
mkcert::installed() { command -v mkcert > /dev/null; }
#
# INSTALL FUNCTION
#
mkcert::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING MKCERT"
	echo "===================================================================="
	echo

	[[ ! -d "$XDG_DOWNLOAD_DIR" ]] && mkdir -p "$XDG_DOWNLOAD_DIR"

	sudo apt install -y libnss3-tools

	wget -O "$XDG_DOWNLOAD_DIR"/mkcert https://dl.filippo.io/mkcert/latest?for=linux/amd64

	chmod +x "$XDG_DOWNLOAD_DIR"/mkcert

	mv "$XDG_DOWNLOAD_DIR"/mkcert /usr/local/bin/mkcert

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
mkcert::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING MKCERT"
	echo "===================================================================="
	echo

	echo "@TODO - mkcert setup"

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
mkcert::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING MKCERT"
	echo "===================================================================="
	echo

	rm -f /usr/local/bin/mkcert

	echo
	echo "DONE!"
	echo
}
