#!/usr/bin/env zsh

# ==================================================================
# install/dotfiles
# ==================================================================
# Swarm Cookbook - Installer Source File
#
# File:         install/dotfiles
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
dotfiles::installed() { return 1; }
#
# INSTALL FUNCTION
#
dotfiles::install()
{
	local source logFile fileDir stub

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "INSTALLING :: DOTFILES"
	echo "===================================================================="
	echo

	if [[ ! -f "$USERDIR/.zshenv" ]]; then
		install::log "Installing ZSH Profile Files to '$USERDIR'" "$logFile"
		source="$REPO"/src/.dotfiles
		install -v -b -C -m 0644 -D -t "$USERDIR" "$source"/.zshenv
		install -v -b -C -m 0644 -D -t "$USERDIR" "$source"/.zprofile
		install -v -b -C -m 0644 -D -t "$USERDIR" "$source"/.zshrc
		install -v -b -C -m 0644 -D -t "$USERDIR" "$source"/.zlogin
		install -v -b -C -m 0644 -D -t "$USERDIR" "$source"/.zlogout
	fi

	install::log "Installing ZSH Loaders / Utility Files to '$ZSHDIR'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_aliases
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_completion
	install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_functions
	if [[ ! -f "$source"/.zsh_ssh ]]; then install -v -C -m 0644 -T "$source"/.zsh_ssh.dist "$ZSHDIR"/.zsh_ssh;
	else install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_ssh; fi
	if [[ ! -f "$source"/.zsh_ssh ]]; then install -v -C -m 0644 -T "$source"/.zsh_ssh.dist "$ZSHDIR"/.zsh_ware;
	else install -v -C -m 0644 -D -t "$ZSHDIR" "$source"/.zsh_ware; fi

	install::log "Installing ZSH Aliases to '$ZSHDIR/aliases'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/aliases
	while IFS= read -r file
	do
		install -v -C -m 0644 -D -t "$ZSHDIR"/aliases "$file"
	done < <(find "$source" -type f)

	install::log "Installing ZSH Completion Files to '$ZSHDIR/completion'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/completion
	install -v -C -m 0644 -T "$source"/git-completion.bash "$ZSHDIR"/completion/git-completion.bash
	install -v -C -m 0644 -T "$source"/git-completion.zsh "$ZSHDIR"/completion/_git

	install::log "Installing ZSH Autoload Functions to '$ZSHDIR/functions'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/functions
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		stub="${fileDir:$len}"
		install -v -C -m 0644 -D -t "$ZSHDIR/functions${stub}" "$file"
	done < <(find "$source" -type f)

	install::log "Installing ZSH Includes to '$ZSHDIR/includes'" "$logFile"

	source="$REPO"/src/.dotfiles/.zsh/includes
	while IFS= read -r file
	do
		install -v -C -m 0644 -D -t "$ZSHDIR/includes" "$file"
	done < <(find "$source" -type f)

	chown -R "$USERNAME":"$USERNAME" "$USERDIR"

	install::log "Writing to .zshrc" "$logFile"

	if ! grep -q "Load .zsh_ssh" "$USERDIR"/.zshrc; then
		{
			echo ""
			echo "# Load .zsh_aliases, if available"
			echo "[[ ! -f \"$ZSHDIR\"/.zsh_aliases ]] || source \"$ZSHDIR\"/.zsh_aliases"
			echo "# Load .zsh_completion, if available"
			echo "[[ ! -f \"$ZSHDIR\"/.zsh_completion ]] || source \"$ZSHDIR\"/.zsh_completion"
			echo "# Load .zsh_functions, if available"
			echo "[[ ! -f \"$ZSHDIR\"/.zsh_functions ]] || source \"$ZSHDIR\"/.zsh_functions"
			echo "# Load .zsh_ssh, if available"
			echo "[[ ! -f \"$ZSHDIR\"/.zsh_ssh ]] || source \"$ZSHDIR\"/.zsh_ssh"
			echo "# Load .zsh_ware, if available"
			echo "[[ ! -f \"$ZSHDIR\"/.zsh_ware ]] || source \"$ZSHDIR\"/.zsh_ware"
		} >> "$USERDIR"/.zshrc
	fi

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dotfiles::config()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "CONFIGURING :: DOTFILES"
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
dotfiles::remove()
{
	local logFile tmpFile

	logFile="${1:-}"
	tmpFile="$(mktemp -t zshrc-XXXXXX)"

	echo
	echo "===================================================================="
	echo "UNINSTALLING :: DOTFILES"
	echo "===================================================================="
	echo

	rm -Rf "$ZSHDIR"
	if grep -q "Load .zsh_ssh" "$USERDIR"/.zshrc; then
		cp "$USERDIR"/.zshrc "$USERDIR"/.zshrc.bak
		sed '/^# Load .zsh_aliases.*$|^# Load .zsh_completion.*$|^# Load .zsh_functions.*$|^# Load .zsh_ssh.*$|^# Load .zsh_ware.*$/d' "$USERDIR"/.zshrc > "$tmpFile"
		sed '/^.* source .*/.zsh_aliases$|^.* source .*/.zsh_completion$|^.* source .*/.zsh_functions$|^.* source .*/.zsh_ssh$|^.* source .*/.zsh_ware$/d' "$tmpFile" > "$USERDIR"/.zshrc
		sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$USERDIR"/.zshrc
	fi

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
dotfiles::test()
{
	local logFile

	logFile="${1:-}"

	echo
	echo "===================================================================="
	echo "TESTING :: DOTFILES"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
