# ==================================================================
# src/apps/ufw
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/ufw
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
ufw::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING UFW"
	echo "===================================================================="
	echo

	sudo apt install -y ufw

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
ufw::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING UFW"
	echo "===================================================================="
	echo

	ufw allow 2376/tcp			# docker
	ufw allow 7946/udp
	ufw allow 7946/tcp
	ufw allow 80/tcp			# http
	ufw allow 8080/tcp			# http
	ufw allow 9090/tcp			# cockpit
	ufw allow 443/tcp			# https
	ufw allow 2377/tcp			# docker
	ufw allow 3000/tcp			# pm2
	ufw allow 3001/tcp			# pm2

	ufw allow 53/udp			# dns
	ufw allow 4789/udp

	ufw allow samba

	ufw reload
	ufw enable

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
ufw::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING UFW"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove ufw

	echo
	echo "DONE!"
	echo
}
