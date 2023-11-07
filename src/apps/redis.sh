# ==================================================================
# src/apps/redis
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/redis
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
redis::installed() { command -v redis-server > /dev/null; }
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

	sudo apt install -y redis-server redis-tools

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
redis::config()
{
	local REDIS_PWD ENV_FILE

	if [[ -z "$HOME" ]]; then
		echo "ERROR :: 'USERDIR' Undefined!"
		exit 1
	fi

	echo
	echo "===================================================================="
	echo "CONFIGURING REDIS"
	echo "===================================================================="
	echo

	if sudo grep -E -q "^# requirepass.*$" /etc/redis/redis.conf; then
		REDIS_PWD="$(getPassword | base64)"
		sudo sed -i "/^supervised.*/c\supervised systemd" /etc/redis/redis.conf
		sudo sed -i "/^# requirepass.*/c\requirepass ${REDIS_PWD}" /etc/redis/redis.conf
	elif sudo grep -E -q "^requirepass.*$" /etc/redis/redis.conf; then
		REDIS_PWD="$(redis::passGET)"
		if [[ -f "$HOME/.zshenv" ]]; then
			ENV_FILE="$HOME/.zshenv"
		elif [[ -f "$HOME/.swarm/.env" ]]; then
			ENV_FILE="$HOME/.swarm/.env"
		elif [[ -f "$REPO"/.env ]]; then
			ENV_FILE="$REPO"/.env
		elif [[ -f "$REPO"/.env.dist ]]; then
			ENV_FILE="$REPO"/.env.dist
		fi
		if ! grep -q "REDISCLI_AUTH" "$ENV_FILE"; then
			{
				echo "# Redis-Server Authentication String"
				echo "export REDISCLI_AUTH=${REDIS_PWD}"
			} >> "$ENV_FILE"
		fi
	fi

	sudo systemctl daemon-reload
	sudo systemctl enable redis-server.service
	sudo systemctl start redis-server

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

	sudo apt purge -y --autoremove redis-server redis-tools

	echo
	echo "DONE!"
	echo
}
