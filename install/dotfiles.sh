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
export ZSHSHARE="${XDG_DATA_DIRS%%:*}/zsh"
export CFGSHARE="${XDG_DATA_DIRS%%:*}/cfg"
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
	local fileDir stub source

	echo
	echo "===================================================================="
	echo "INSTALLING :: DOTFILES"
	echo "===================================================================="
	echo

	if [ ! "$(getent group zshusers)" ]; then sudo groupadd zshusers; fi

	if [[ ! -f "$ZSHSHARE/zshenv" ]]; then
		log::file "Installing ZSH Dotfiles to '$ZSHSHARE'"
		source="$REPO"/src/.dotfiles
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zshenv"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zprofile"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zshrc"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zlogin"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zlogout"
	fi

	if [[ ! -f "$ZSHSHARE/zsh_functions" ]]; then
		log::file "Installing ZSH Loaders / Utility Files to '$ZSHSHARE'"
		source="$REPO"/src/.dotfiles/.zsh
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zsh_aliases"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zsh_completion"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE" "$source/zsh_functions"
	fi

	source="$REPO"/src/.dotfiles/.zsh
	log::file "Installing .zsh_ssh & .zsh_ware directly to '$ZSHDIR'"
	if [[ ! -f "$ZSHDIR/.zsh_ssh" ]]; then install -v -b -C -m 0660 -T "$source/zsh_ssh" "$ZSHDIR/.zsh_ssh"; fi
	if [[ ! -f "$ZSHDIR/.zsh_ware" ]]; then install -v -b -C -m 0660 -T "$source/zsh_ware.dist" "$ZSHDIR/.zsh_ware"; fi

	log::file "Installing ZSH Aliases to '$ZSHSHARE/aliases'"
	source="$REPO"/src/.dotfiles/.zsh/aliases
	while IFS= read -r file
	do
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE/aliases" "$file"
	done < <(find "$source" -type f)

	log::file "Installing ZSH Completion Files to '$ZSHSHARE/completion'"
	source="$REPO"/src/.dotfiles/.zsh/completion
	sudo mkdir -p "$ZSHSHARE/completion"
	sudo install -v -b -C -m 0660 -T "$source/git-completion.bash" "$ZSHSHARE/completion/git-completion.bash"
	sudo install -v -b -C -m 0660 -T "$source/_git" "$ZSHSHARE/completion/_git"

	log::file "Installing ZSH Autoload Functions to '$ZSHSHARE/functions'"
	source="$REPO"/src/.dotfiles/.zsh/functions
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		stub="${fileDir:$len}"
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE/functions${stub}" "$file"
	done < <(find "$source" -type f)

	log::file "Installing ZSH Includes to '$ZSHSHARE/includes'"
	source="$REPO"/src/.dotfiles/.zsh/includes
	while IFS= read -r file
	do
		sudo install -v -b -C -m 0660 -D -t "$ZSHSHARE/includes" "$file"
	done < <(find "$source" -type f)

	log::file "Set file and folder permissions on '$ZSHSHARE'"
	sudo chown -R root:zshusers "$ZSHSHARE"
	while IFS= read -r dir
	do
		sudo chmod 0660 "$dir"
	done < <(find "$ZSHSHARE" -type d)

	log::file "Installing Shared Configuration Files to '$CFGSHARE'"
	source="$REPO"/src/.dotfiles/cfg
	len="${#source}"
	while IFS= read -r file
	do
		fileDir="${file%/*}"
		stub="${fileDir:$len}"
		sudo install -v -b -C -m 0660 -D -t "$CFGSHARE${stub}" "$file"
	done < <(find "$source" -type f)

	local users=("root:/root")

	for username in /home/*
	do
		users+=("$username:/home/$username")
	done

	for userinfo in "${users[@]}"
	do
		username="${userinfo%:*}"
		userdir="${userinfo##*:}"
		userzsh="$userdir/.zsh"
		if [[ ! -d "$userzsh" ]]; then sudo mkdir -p "$userzsh"; fi
		# add to zshusers group
		sudo usermod -aG zshusers "$username"

		log::file "Linking user '$username' to ZSH Dotfiles in '$ZSHSHARE'"
		[[ ! -L "$userdir/.zshenv" ]] && sudo ln -sf "$ZSHSHARE/zshenv" "$userdir/.zshenv"
		[[ ! -L "$userdir/.zprofile" ]] && sudo ln -sf "$ZSHSHARE/zprofile" "$userdir/.zprofile"
		[[ ! -f "$userdir/.zshrc" ]] && sudo install -v -C -m 0644 -T "$ZSHSHARE/zshrc_usr" "$userdir/.zshrc"
		[[ ! -L "$userdir/.zlogin" ]] && sudo ln -sf "$ZSHSHARE/zlogin" "$userdir/.zlogin"
		[[ ! -L "$userdir/.zlogout" ]] && sudo ln -sf "$ZSHSHARE/zlogout" "$userdir/.zlogout"

		log::file "Linking user '$username' to ZSH Loader / Utility Files in '$ZSHSHARE'"
		[[ ! -L "$userdir/.zsh_aliases" ]] && sudo ln -sf "$ZSHSHARE/zsh_aliases" "$userzsh/.zsh_aliases"
		[[ ! -L "$userdir/.zsh_completion" ]] && sudo ln -sf "$ZSHSHARE/zsh_completion" "$userzsh/.zsh_completion"
		[[ ! -L "$userdir/.zsh_functions" ]] && sudo ln -sf "$ZSHSHARE/zsh_functions" "$userzsh/.zsh_functions"

		sudo chown "$username":"$username" "$userdir/.z*"

		log::file "Linking user '$username' to ZSH Aliases in '$ZSHSHARE/aliases'"
		sudo mkdir -p "$userzsh/aliases"
		while IFS= read -r file
		do
			filename="${file%%*/}"
			[[ ! -L "$userzsh/aliases/$filename" ]] && sudo ln -sf "$file" "$userzsh/aliases/$filename"
		done < <(find "$ZSHSHARE/aliases" -type f)

		sudo chown "$username":"$username" "$userzsh/aliases/*"

		log::file "Linking user '$username' to ZSH Completion Files in '$ZSHSHARE/completion'"
		sudo mkdir -p "$userzsh/completion"
		while IFS= read -r file
		do
			[[ ! -L "$userzsh/completion/$filename" ]] && sudo ln -sf "$file" "$userzsh/completion/$filename"
		done < <(find "$ZSHSHARE/completion" -type f)

		sudo chown "$username":"$username" "$userzsh/completion/*"

		log::file "Linking user '$username' to ZSH Functions in '$ZSHSHARE/functions'"
		sudo mkdir -p "$userzsh/completion"
		source="$ZSHSHARE/functions"
		len="${#source}"
		while IFS= read -r file
		do
			filedir="${file%/*}"
			stub="${filedir:$len}"
			[[ ! -d "$userzsh/functions${stub}" ]] && sudo mkdir -p "$userzsh/functions${stub}"
			[[ ! -L "$userzsh/functions${stub}/$filename" ]] && sudo ln -sf "$file" "$userzsh/functions${stub}/$filename"
		done < <(find "$ZSHSHARE/functions" -type f)

		chown -R "$username":"$username" "$userzsh/functions/*"

		log::file "Linking user '$username' to ZSH Include Files in '$ZSHSHARE/includes'"
		mkdir -p "$userzsh/includes"
		while IFS= read -r file
		do
			[[ ! -L "$userzsh/includes/$filename" ]] && sudo ln -sf "$file" "$userzsh/includes/$filename"
		done < <(find "$ZSHSHARE/includes" -type f)

		chown "$username":"$username" "$userzsh/includes/*"
	done

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
dotfiles::config()
{
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
	echo
	echo "===================================================================="
	echo "UNINSTALLING :: DOTFILES"
	echo "===================================================================="
	echo

	local users=("root:/root")

	for username in /home/*
	do
		users+=("$username:/home/$username")
	done

	for userinfo in "${users[@]}"
	do
		username="${userinfo%:*}"
		userdir="${userinfo##*:}"
		userzsh="$userdir/.zsh"
		# remove all symbolic links
		log::file "Removing symbolic links & files for user '$username''"
		rm -Rf "$userzsh"
		rm -f "$userdir/.z*"
		if [[ -d "$userdir/.bash_archive" ]]; then
			log::file "Restoring .bash* files for user '$username'"
			for file in "$userdir"/.bash_archive/*
			do
				filename="${file##*/}"
				mv "$file" "$userdir/$filename"
			done
		fi
	done

	log::file "Removing '$ZSHSHARE' folder and contents"
	rm -Rf "$ZSHSHARE"

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
dotfiles::test()
{
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
