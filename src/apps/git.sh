# shellcheck disable=SC2155,SC1090
# ==================================================================
# src/apps/git
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/git
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
git::install() {
	echo
	echo "===================================================================="
	echo "INSTALLING GIT"
	echo "===================================================================="
	echo

	sudo apt install -y git

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
git::config()
{
	local RESULT OK_LABEL CANCEL_LABEL DIALOG_BACKTITLE DIALOG_TITLE DIALOG_TEXT HEIGHT WIDTH DIALOG_INIT
	local GIT_USER GIT_USER_DEFAULT GIT_EMAIL_DEFAULT status
	local NODE_ID="$(docker info -f '{{.Swarm.NodeID}}')"

	source "$SWARMDIR"/.env

	echo
	echo "===================================================================="
	echo "CONFIGURING GIT"
	echo "===================================================================="
	echo

	GIT_USER_DEFAULT="Username"
	DIALOG_TITLE="Git Username"
	DIALOG_TEXT="Enter a username for the global git user:"
	DIALOG_INIT="${GIT_USER:-${GIT_USER_DEFAULT}}"

	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)

	status=$?

	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned!"
			hashSET NODE:"${NODE_ID}" GIT_USER "$RESULT"
			writeENV GIT_USER "$RESULT" "$USERDIR"/cfg/.node
			git config --global user.name "$RESULT"
			;;
	esac

	local RESULT

	GIT_EMAIL_DEFAULT="user@users.noreply.github.com"
	DIALOG_TITLE="Git Email Address"
	DIALOG_TEXT="Enter an email address for the global git user:"
	DIALOG_INIT="${GIT_EMAIL:-${GIT_EMAIL_DEFAULT}}"

	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
			--cancel-label "${CANCEL_LABEL:-Cancel}" \
			--backtitle "${DIALOG_BACKTITLE}" \
			--title "${DIALOG_TITLE}" --cr-wrap --clear \
			--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)

	status=$?

	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned!"
			hashSET NODE:"${NODE_ID}" GIT_EMAIL "$RESULT"
			writeENV GIT_EMAIL "$RESULT" "$USERDIR"/cfg/.node
			git config --global user.email "$RESULT"
			;;
	esac

	local RESULT

	GIT_FILEMODE_DEFAULT="false"
	DIALOG_TITLE="Git FileMode"
	DIALOG_TEXT="Enter the Core.FileMode value:"
	DIALOG_INIT="${GIT_FILEMODE:-${GIT_FILEMODE_DEFAULT}}"

	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
			--cancel-label "${CANCEL_LABEL:-Cancel}" \
			--backtitle "${DIALOG_BACKTITLE}" \
			--title "${DIALOG_TITLE}" --cr-wrap --clear \
			--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)

	status=$?

	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned!"
			hashSET NODE:"${NODE_ID}" GIT_EMAIL "$RESULT"
			writeENV GIT_EMAIL "$RESULT" "$USERDIR"/cfg/.node
			git config --global user.email "$RESULT"
			;;
	esac

	clear

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
git::remove() {
	echo
	echo "===================================================================="
	echo "UNINSTALLING GIT"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove git

	echo
	echo "DONE!"
	echo
}
