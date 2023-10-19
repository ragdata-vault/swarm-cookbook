#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/logwatch
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/logwatch
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
logwatch::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING LOGWATCH"
	echo "===================================================================="
	echo

	apt install -y logwatch

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
logwatch::config()
{
	local USERNAME="${SUDO_USER:-$(whoami)}"

	echo
	echo "===================================================================="
	echo "CONFIGURING LOGWATCH"
	echo "===================================================================="
	echo

	local ADMIN_EMAIL SYSTEM_EMAIL NODE_ID

	NODE_ID="$(docker info -f '{{.Swarm.NodeID}}')"

	ADMIN_EMAIL="$(hashGET NODE:"${NODE_ID}" ADMIN_EMAIL)"
	SYSTEM_EMAIL="$(hashGET NODE:"${NODE_ID}" SYSTEM_EMAIL)"

	cp /usr/share/logwatch/default.conf/logwatch.conf /usr/share/logwatch/default.conf/logwatch.conf~

	sed -i "/^Output.*/c\Output = mail" /usr/share/logwatch/default.conf/logwatch.conf
	sed -i "/^Format.*/c\Format = html" /usr/share/logwatch/default.conf/logwatch.conf
	sed -i "/^MailTo.*/c\MailTo = ${ADMIN_EMAIL}" /usr/share/logwatch/default.conf/logwatch.conf
	sed -i "/^MailFrom.*/c\MailFrom = ${SYSTEM_EMAIL}" /usr/share/logwatch/default.conf/logwatch.conf
	sed -i "/^Detail.*/c\Detail = High" /usr/share/logwatch/default.conf/logwatch.conf

	install -v -m 0755 -C -D -t /etc/cron.daily /"$SWARMDIR"/inc/cron/logwatch

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
logwatch::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING LOGWATCH"
	echo "===================================================================="
	echo

	apt purge -y logwatch

	echo
	echo "DONE!"
	echo
}
