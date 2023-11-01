# ==================================================================
# src/apps/nodejs
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/nodejs
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
nodejs::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING NODEJS"
	echo "===================================================================="
	echo

	export DEBIAN_FRONTEND=noninteractive

	sudo add-apt-repository -y -r ppa:chris-lea/node.js

	local NODEREPO="node_18.x" DISTRO="jammy"
	local keyring="/usr/share/keyrings" local_node_key="$keyring/nodesource.gpg"
	local node_key_url="https://deb.nodesource.com/gpgkey/nodesource.gpg.key"

	wget -q -O - $node_key_url | gpg --dearmor | tee $local_node_key >/dev/null

	echo "deb [signed-by=$local_node_key] https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" | sudo tee /etc/apt/sources.list.d/nodesource.list
	echo "deb-src [signed-by=$local_node_key] https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" | sudo tee /etc/apt/sources.list.d/nodesource.list

	sudo apt update && sudo apt install -y nodejs

	# Uncomment below to install the Yarn package manager
	# yarn_site='https://dl.yarnpkg.com/debian'
	# yarn_key_url="$yarn_site/pubkey.gpg"
	# local_yarn_key="$keyring/yarnkey.gpg"
	# wget -q -O - $yarn_key_url | gpg --dearmor | tee $local_yarn_key >/dev/null
	# echo "deb [signed-by=$local_yarn_key] $yarn_site stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	# sudo apt update -y && sudo apt install -y yarn

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
nodejs::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING NODEJS"
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
nodejs::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING NODEJS"
	echo "===================================================================="
	echo

	rm -rf /usr/local/bin/npm
	rm -rf /usr/local/share/man/man1/node*
	rm -rf /usr/local/lib/dtrace/node.d
	rm -rf "$USERDIR"/.npm
	rm -rf "$USERDIR"/.node-gyp
	rm -rf /opt/local/bin/node
	rm -rf /opt/local/include/node
	rm -rf /opt/local/lib/node_modules

	rm -rf /usr/local/lib/node*
	rm -rf /usr/local/include/node*
	rm -rf /usr/local/bin/node*
	rm -rf /usr/bin/node*
	rm -rf /usr/bin/nodejs*

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
nodejs::test()
{
	echo
	echo "===================================================================="
	echo "TESTING NODEJS"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
