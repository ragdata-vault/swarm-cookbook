# ==================================================================
# src/apps/toolset-dev
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/toolset-dev
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
toolset-dev::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING TOOLSET-DEV"
	echo "===================================================================="
	echo

	export DEBIAN_FRONTEND=noninteractive

	sudo apt install -y mkcert libffi-dev libgdbm-dev libncurses5-dev automake libtool gcc g++ make colordiff
	sudo apt install -y zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev libc-bin

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
toolset-dev::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING TOOLSET-DEV"
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
toolset-dev::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING TOOLSET-DEV"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
toolset-dev::test()
{
	echo
	echo "===================================================================="
	echo "TESTING TOOLSET-DEV"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
