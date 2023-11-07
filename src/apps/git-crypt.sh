# ==================================================================
# src/apps/git-crypt
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/git-crypt
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
git-crypt::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}GIT-CRYPT HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
git-crypt::requires() { echo; }
#
# INSTALLED FUNCTION
#
git-crypt::installed() { command -v git-crypt > /dev/null; }
#
# INSTALL FUNCTION
#
git-crypt::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING GIT-CRYPT"
	echo "===================================================================="
	echo

	wget -O /home/"$SUDO_USER"/downloads/git-crypt.0.7.0.tar.gz https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.7.0.tar.gz

	tar zxvf /home/"$SUDO_USER"/downloads/git-crypt.0.7.0.tar.gz

	cd /home/"$SUDO_USER"/downloads/git-crypt.0.7.0 || return 1

	make

	make install PREFIX=/usr/local/bin

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
git-crypt::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING GIT-CRYPT"
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
git-crypt::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING GIT-CRYPT"
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
git-crypt::test()
{
	echo
	echo "===================================================================="
	echo "TESTING GIT-CRYPT"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
