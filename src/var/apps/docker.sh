#!/usr/bin/env zsh

# ==================================================================
# src/var/apps/docker
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/var/apps/docker
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
docker::installed() { command -v docker; }
#
# INSTALL FUNCTION
#
docker::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DOCKER"
	echo "===================================================================="
	echo

	local ver=0

	if command -v docker > /dev/null; then
		ver="$(docker -v | awk '{print $3}')"
		ver="${ver%%.*}"
	fi

	if [[ "$ver" -lt 20 ]]; then

		local MY_USER

		# MY_USER
		MY_USER_DEFAULT="username"
		DIALOG_BACKTITLE="SWARM APP INSTALLER"
		DIALOG_TITLE="System Username"
		DIALOG_TEXT="Enter your username on this host:"
		DIALOG_INIT="${MY_USER:-${MY_USER_DEFAULT}}"
		RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
				--cancel-label "${CANCEL_LABEL:-Cancel}" \
				--backtitle "${DIALOG_BACKTITLE}" \
				--title "${DIALOG_TITLE}" --cr-wrap --clear \
				--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
		status=$?
		case "$status" in
			0)
				[[ -z "$RESULT" ]] && errorReturn "No result returned!"
				MY_USER="$RESULT"
				if grep -q "MY_USER" "$SWARMDIR"/.node; then
					sed -i "/^MY_USER.*/c\MY_USER=$MY_USER" "$SWARMDIR/.node"
				else
					echo "MY_USER=$MY_USER" >> "$SWARMDIR"/.node
				fi
				if [[ -n "$REDISCLI_AUTH" ]] && [[ -n "$HASH_KEY" ]]; then
					hashSET "$HASH_KEY" MY_USER "$MY_USER"
				fi
				;;
		esac

		sudo apt purge -y --autoremove docker.io docker-doc docker-compose podman-docker containerd runc

		sudo apt update

		sudo install -m 0755 -d /etc/apt/keyrings

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

		chmod a+r /etc/apt/keyrings/docker.gpg

		echo \
		  "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
		  \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" | \
		  tee /etc/apt/sources.list.d/docker.list > /dev/null

		sudo apt update

		sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

		sudo groupadd docker

		sudo usermod -aG docker "$MY_USER"

		cd /etc/bash_completion.d/ || return 1

		sudo curl -O https://raw.githubusercontent.com/docker/cli/b75596e1e4d5295ac69b9934d1bd8aff691a0de8/contrib/completion/bash/docker

		mkdir -p "$XDG_DOWNLOAD_DIR"

		cd "$XDG_DOWNLOAD_DIR" || return 1

		wget https://github.com/MatchbookLab/local-persist/releases/download/v1.3.0/local-persist-linux-amd64

		sudo mv local-persist-linux-amd64 /usr/bin/docker-volume-local-persist

		chmod +x /usr/bin/docker-volume-local-persist

		sudo install -v -C -D -t /etc/systemd/system "$SWARMDIR"/etc/docker/docker-volume-local-persist.service

		sudo systemctl daemon-reload
		sudo systemctl enable docker-volume-local-persist
		sudo systemctl enable docker.service
		sudo systemctl enable containerd.service
		sudo systemctl start docker
		sudo systemctl start docker-volume-local-persist
	fi

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
docker::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DOCKER"
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
docker::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DOCKER"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo rm -f /etc/systemd/system/docker-volume-local-persist.service

	sudo systemctl disable docker-volume-local-persist
	sudo systemctl disable docker.service
	sudo systemctl disable containerd.service
	sudo systemctl stop docker
	sudo systemctl stop docker-volume-local-persist

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
docker::test()
{
	echo
	echo "===================================================================="
	echo "TESTING DOCKER"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
