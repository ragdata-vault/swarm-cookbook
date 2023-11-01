# ==================================================================
# src/apps/locale
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/locale
# Author:       Ragdata
# Date:         09/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren Poulton (Ragdata)
# ==================================================================
# DEPENDENCIES
# ==================================================================
if [[ -z "$isLOC" ]]; then source "$ZSHDIR"/functions/regex_aliases.zsh; fi
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# INSTALLED FUNCTION
#
locale::installed() { command -v locale; }
#
# INSTALL FUNCTION
#
locale::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING LOCALE"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
locale::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING LOCALE"
	echo "===================================================================="
	echo

	if [[ -n "$NODE_LOCALE" ]]; then
		LOC="$NODE_LOCALE"
	else
		LOC="en.US.UTF-8"
	fi

	if [[ -z "$LOCALE" ]]; then
		LOCALE_DEFAULT="$LOC"
		DIALOG_BACKTITLE="SWARM APP INSTALLER"
		DIALOG_TITLE="Set Locale"
		DIALOG_TEXT="Enter your preferred locale:"
		DIALOG_INIT="${NODE_LOCALE:-${LOCALE_DEFAULT}}"
		RESULT=$(dialog --ok-label "${OK_LABEL:-OK}" \
				--cancel-label "${CANCEL_LABEL:-Cancel}" \
				--backtitle "${DIALOG_BACKTITLE}" \
				--title "${DIALOG_TITLE}" --cr-wrap --clear \
				--inputbox "\n${DIALOG_TEXT}\n" "${HEIGHT:-15}" "${WIDTH:-50}" "${DIALOG_INIT}" 3>&1 1>&2 2>&3)
		status=$?
		case "$status" in
			0)
				[[ -z "$RESULT" ]] && errorReturn "No result returned!"
				NODE_LOCALE="$RESULT"
				if grep -q "NODE_LOCALE" "$SWARMDIR"/.node; then
					sed -i "/^NODE_LOCALE/c\NODE_LOCALE=$RESULT" "$SWARMDIR"/.node
				else
					echo "NODE_LOCALE=$NODE_LOCALE" >> "$SWARMDIR"/.node
				fi
				if [[ -n "$REDISCLI_AUTH" ]] && [[ -n "$HASH_KEY" ]]; then
					hashSET "$HASH_KEY" NODE_LOCALE "$NODE_LOCALE"
				fi
				;;
		esac

		locale-gen "$NODE_LOCALE"

		update-locale LANG="$NODE_LOCALE"

		local -a users

		users=("root:/root")

		for userPath in /home/*
		do
			userName="${userPath##*/}"
			users+=("$userName:$userPath")
		done

		for user in "${users[@]}"
		do
			userPath="${user##*:}"
			userName="${user%%:*}"
			zshrcFile="$userPath/.zshrc"
			if grep -q "export LANG" "$zshrcFile"; then
				sed -i "s/export LANG=.*/export LANG=\"$LOCALE\"/" "$zshrcFile"
				sed -i "s/export LANGUAGE=.*/export LANGUAGE=\"$LOCALE\"/" "$zshrcFile"
				sed -i "s/export LC_ALL=.*/export LC_ALL=\"$LOCALE\"/" "$zshrcFile"
			else
				{ echo ""; echo "# export locale"; echo "export LANG=\"$NODE_LOCALE\""; echo "export LANGUAGE=\"$NODE_LOCALE\""; echo "export LC_ALL=\"$NODE_LOCALE\""; } >> "$zshrcFile"
			fi
		done
	fi

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
locale::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING LOCALE"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
locale::test()
{
	echo
	echo "===================================================================="
	echo "TESTING LOCALE"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
