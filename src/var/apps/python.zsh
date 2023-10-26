#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/python
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/python
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
python::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING PYTHON"
	echo "===================================================================="
	echo

	sudo apt install -y python3-full python3-dev python3-pip python3.11-full python3-certbot-nginx
	sudo apt install -y python3-software-properties python3-dateutil python3-debconf python3-debian python3-venv python3-django

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
python::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING PYTHON"
	echo "===================================================================="
	echo

	if [[ ! -f /usr/bin/python2 ]]; then ln -s /usr/bin/python2.7 /usr/bin/python2
	if [[ ! -f /usr/bin/python3 ]]; then ln -s /usr/bin/python3.11 /usr/bin/python3

	sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11 99

	if [[ -f /usr/bin/python3.8 ]]; then update-alternatives --install /usr/bin/python python /usr/bin/python3.8 80

	sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 20

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
python::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING PYTHON"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove python3-full python3-pip python3.11-full

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
python::test()
{
	echo
	echo "===================================================================="
	echo "TESTING PYTHON"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
