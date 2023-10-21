#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/redis
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/redis
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
redis::installed()
{
	command -v redis-server
}
#
# INSTALL FUNCTION
#
redis::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING REDIS"
	echo "===================================================================="
	echo

	apt install -y redis-server redis-tools

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
redis::config()
{
	local USERNAME="${SUDO_USER:-$(whoami)}" REDIS_PWD

	echo
	echo "===================================================================="
	echo "CONFIGURING REDIS"
	echo "===================================================================="
	echo

	sed -i "/^supervised.*/c\supervised systemd" /etc/redis/redis.conf
	sed -i "/^# requirepass.*/c\requirepass ${REDIS_PWD}" /etc/redis/redis.conf

	if ! grep -q REDISCLI_AUTH /"$SWARMDIR"/cfg/.env; then
		echo "export REDISCLI_AUTH=${REDIS_PWD}" >> /"$SWARMDIR"/cfg/.env
	fi

	systemctl daemon-reload
	systemctl enable redis-server.service
	systemctl start redis-server

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
redis::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING REDIS"
	echo "===================================================================="
	echo

	apt purge -y redis-server redis-tools

	echo
	echo "DONE!"
	echo
}
