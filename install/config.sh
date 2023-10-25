#!/usr/bin/env zsh

# ==================================================================
# install/config
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/config
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
config::installed() { return 1; }
#
# INSTALL FUNCTION
#
config::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING :: CONFIG FILES"
	echo "===================================================================="
	echo

	source="$REPO"

	install::log "Installing distribution versions of config files" "$logFile"

	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.env.dist
	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.node.dist

	install::log "Installing config files in '$SWARMDIR', if available" "$logFile"

	if [[ ! -f "$SWARMDIR"/.env ]]; then install -v -m 0755 -C -T "$source"/.env.dist "$SWARMDIR"/.env; fi
	if [[ ! -f "$SWARMDIR"/.node ]]; then install -v -m 0755 -C -T "$source"/.node.dist "$SWARMDIR"/.node; fi

	chown -R "$USERNAME":"$USERNAME" "$SWARMDIR"

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
config::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING :: CONFIG FILES"
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
config::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: CONFIG FILES"
	echo "===================================================================="
	echo

	install::log "Removing config files in '$SWARMDIR'" "$logFile"

	rm -f "$SWARMDIR/.env*" "$SWARMDIR/.node*"

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
config::test()
{
	echo
	echo "===================================================================="
	echo "TESTING :: CONFIG FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
