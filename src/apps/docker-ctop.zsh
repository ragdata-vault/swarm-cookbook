#!/usr/bin/env zsh

# ==================================================================
# src/apps/docker-ctop
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/docker-ctop
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
# INSTALLED FUNCTION
#
docker-ctop::installed() { command -v docker-ctop; }
#
# INSTALL FUNCTION
#
docker-ctop::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DOCKER-CTOP"
	echo "===================================================================="
	echo

	curl -fsSL https://azlux.fr/repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/azlux-archive-keyring.gpg
	echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian \
        $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azlux.list >/dev/null
	sudo apt update
	sudo apt install -y docker-ctop

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
docker-ctop::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DOCKER-CTOP"
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
docker-ctop::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DOCKER-CTOP"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove docker-ctop

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
docker-ctop::test()
{
	echo
	echo "===================================================================="
	echo "TESTING DOCKER-CTOP"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
