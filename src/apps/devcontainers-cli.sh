# ==================================================================
# src/apps/devcontainers-cli.zsh
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/devcontainers-cli.zsh
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
devcontainers-cli::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}DEVCONTAINERS-CLI HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
devcontainers-cli::requires() { echo; }
#
# INSTALLED FUNCTION
#
devcontainers-cli::installed() { command -v devcontainers-cli > /dev/null; }
#
# INSTALL FUNCTION
#
devcontainers-cli.zsh::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING DEVCONTAINERS-CLI"
	echo "===================================================================="
	echo

	nvm use --lts
	npm install -g @devcontainers/cli

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
devcontainers-cli.zsh::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING DEVCONTAINERS-CLI"
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
devcontainers-cli.zsh::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING DEVCONTAINERS-CLI"
	echo "===================================================================="
	echo

	nvm use --lts
	npm uninstall -g @devcontainers/cli

	echo
	echo "DONE!"
	echo
}
