#!/usr/bin/env zsh

# ==================================================================
# install/swarm
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/swarm
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
swarm::installed() { return 1; }
#
# INSTALL FUNCTION
#
swarm::install()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "INSTALLING :: SWARM FILES"
	echo "===================================================================="
	echo

	install::log "Installing App Installer Files to '$SWARMDIR/apps'" "$logFile"

	source="$REPO"/src/var/apps
	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t "$SWARMDIR"/apps "$file"
	done < <(find "$source" -type f)

	install::log "Installing Script Files to '$SWARMDIR/scripts'" "$logFile"

	source="$REPO"/src/var/scripts
	while IFS= read -r file
	do
		install -v -C -m 0755 -D -t "$SWARMDIR"/scripts "$file"
	done < <(find "$source" -type f)

	install::log "Installing Stack Files to '$SWARMDIR/stacks'" "$logFile"

	source="$REPO"/src/var/stacks
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		fileName="${file##*/}"
		stub="${fileDir:$len}"
		[[ "$fileName" == ".stack" ]] && mode="0755" || mode="0644"
		if [[ "$fileName" == ".env.dist" ]]; then
			fullName="$SWARMDIR"/stacks${stub}/.env
			if [[ -f "$fullName" ]]; then
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$fullName"
			else
				install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
			fi
		else
			install -v -C -m "$mode" -D -t "$SWARMDIR/stacks${stub}" "$file"
		fi
	done < <(find "$source" -type f)

	install::log "Installing /etc files to '$SWARMDIR/etc'" "$logFile"

	source="$REPO"/src/var/etc
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		fileName="${file##*/}"
		stub="${fileDir:$len}"
		install -v -C -m 0644 -D -t "$SWARMDIR/etc${stub}" "$file"
	done < <(find "$source" -type f)

	chown -R "$USERNAME":"$USERNAME" "$SWARMDIR"

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
swarm::config()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "CONFIGURING :: SWARM FILES"
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
swarm::remove()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "UNINSTALLING :: SWARM FILES"
	echo "===================================================================="
	echo

	install::log "Removing files from '$SWARMDIR'" "$logFile"
	rm -Rf "$SWARMDIR"

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
swarm::test()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "TESTING :: SWARM FILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
