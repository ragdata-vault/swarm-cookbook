#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/mkcert
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/mkcert
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
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "INSTALLING MKCERT"
	echo "===================================================================="
	echo

	[[ ! -d /"$USERDIR"/downloads ]] && mkdir -p /"$USERDIR"/downloads

	apt install -y libnss3-tools

	wget -O /"$USERDIR"/downloads/mkcert https://dl.filippo.io/mkcert/latest?for=linux/amd64

	chmod +x /"$USERDIR"/downloads/mkcert

	mv /"$USERDIR"/downloads/mkcert /usr/local/bin/mkcert

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
