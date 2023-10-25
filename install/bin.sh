#!/usr/bin/env zsh
# shellcheck disable=SC2154,SC2181
# ==================================================================
# install/bin
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/bin
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
bin::installed() { return 1; }
#
# INSTALL FUNCTION
#
bin::install()
{
	local source logFile

	logFile="${1:-}"
	source="$REPO"/src/bin

	echo
	echo "===================================================================="
	echo "INSTALLING :: BIN FILES"
	echo "===================================================================="
	echo

	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t /usr/local/bin "$file"
		if [[ $? -ne 0 ]]; then
			install::log "Possible problem installing '$file' to /usr/local/bin - exit code $?" "$logFile"
		else
			install::log "Installed '$file' to /usr/local/bin OK!" "$logFile"
		fi
	done < <(find "$source" -type f)

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
bin::config()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "CONFIGURING BIN"
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
bin::remove()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "UNINSTALLING BIN"
	echo "===================================================================="
	echo

	cd /usr/local/bin || return 1
	rm -f app* stack* swarm* cluster*
	cd - || return 1

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
bin::test()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "TESTING BIN"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
