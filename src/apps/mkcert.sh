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
# INSTALL FUNCTION
#
mkcert::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING MKCERT"
	echo "===================================================================="
	echo

	[[ ! -d "$HOME"/downloads ]] && mkdir -p "$HOME"/downloads

	sudo apt install -y libnss3-tools

	wget -O "$HOME"/downloads/mkcert https://dl.filippo.io/mkcert/latest?for=linux/amd64

	chmod +x "$HOME"/downloads/mkcert

	mv "$HOME"/downloads/mkcert /usr/local/bin/mkcert

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
