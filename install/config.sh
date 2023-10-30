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

	local source RESULT

	source="$REPO"

	source "$source"/.node.dist

	log::file "Installing distribution versions of config files"

	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.env.dist
	install -v -C -m 0755 -D -t "$SWARMDIR" "$source"/.node.dist

	log::file "Installing config files in '$SWARMDIR', if available"

	if [[ ! -f "$SWARMDIR"/.env ]]; then install -v -m 0755 -C -T "$source"/.env.dist "$SWARMDIR"/.env; fi
	if [[ ! -f "$SWARMDIR"/.node ]]; then touch "$SWARMDIR"/.node; else source "$SWARMDIR"/.node; fi

	# GLOBAL VARS
	DIALOG_BACKTITLE="NODE CONFIGURATION"

	# NODE_TYPE
	DIALOG_TITLE="Node Type"
	DIALOG_TEXT="Enter node type:"
	DIALOG_INIT="${NODE_TYPE:-Manager}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 NODE_TYPE "$RESULT"
			;;
	esac

	local RESULT NIC_ID

	# NIC_ID
	DIALOG_TITLE="Network Interface"
	DIALOG_TEXT="Enter network interface name:"
	DIALOG_INIT="${NIC_ID:-eth0}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 NIC_ID "$RESULT"
			;;
	esac

	local RESULT IPv4_DEFAULT NODE_IPv4

	# NODE_IPv4
	NIC_ID="$(configGET NODE:1 NIC_ID)"
	IPv4_DEFAULT=$(ifconfig "${NIC_ID}" | awk '$2~/^flags/{_1=$1;getline;if($1~/^inet/){print $2}}')
	DIALOG_TITLE="Public IPv4 Address"
	DIALOG_TEXT="Enter public IPv4 address:"
	DIALOG_INIT="${NODE_IPv4:-${IPv4_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 NODE_IPv4 "$RESULT"
			;;
	esac

	local RESULT HOSTNAME_DEFAULT NODE_HOSTNAME

	# NODE_HOSTNAME
	HOSTNAME_DEFAULT="$(hostname)"
	DIALOG_TITLE="Hostname"
	DIALOG_TEXT="Enter the name of this host (without domain):"
	DIALOG_INIT="${NODE_HOSTNAME:-${HOSTNAME_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 NODE_HOSTNAME "$RESULT"
			;;
	esac

	local RESULT DOMAIN_DEFAULT NODE_DOMAIN

	# NODE_DOMAIN
	DOMAIN_DEFAULT="local"
	DIALOG_TITLE="Host Domain"
	DIALOG_TEXT="Enter the domain name for this host\n(without hostname):"
	DIALOG_INIT="${NODE_DOMAIN:-${DOMAIN_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 NODE_DOMAIN "$RESULT"
			;;
	esac

	local RESULT MY_USER_DEFAULT MY_USER

	# MY_USER
	MY_USER_DEFAULT="Username"
	DIALOG_TITLE="System Username"
	DIALOG_TEXT="Enter YOUR username on this host:"
	DIALOG_INIT="${MY_USER:-${MY_USER_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 MY_USER "$RESULT"
			;;
	esac

	local RESULT ADMIN_EMAIL_DEFAULT ADMIN_EMAIL

	# ADMIN_EMAIL
	ADMIN_EMAIL_DEFAULT="admin@example.com"
	DIALOG_TITLE="Admin Email Address"
	DIALOG_TEXT="Enter an admin email address:"
	DIALOG_INIT="${ADMIN_EMAIL:-${ADMIN_EMAIL_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 ADMIN_EMAIL "$RESULT"
			;;
	esac

	local RESULT SYSTEM_EMAIL_DEFAULT SYSTEM_EMAIL

	# SYSTEM_EMAIL
	SYSTEM_EMAIL_DEFAULT="system@example.com"
	DIALOG_TITLE="System Email Address"
	DIALOG_TEXT="Enter a system email address:"
	DIALOG_INIT="${SYSTEM_EMAIL:-${SYSTEM_EMAIL_DEFAULT:-}}"
	RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
		--cancel-label "${CANCEL_LABEL:-Cancel}" \
		--backtitle "${DIALOG_BACKTITLE}" \
		--title "${DIALOG_TITLE}" --cr-wrap --clear \
		--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
	status=$?
	case "$status" in
		0)
			[[ -z "$RESULT" ]] && errorReturn "No Result Returned"
			configSET NODE:1 SYSTEM_EMAIL "$RESULT"
			;;
	esac

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

	log::file "Removing config files in '$SWARMDIR'"

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
