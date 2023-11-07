# ==================================================================
# src/apps/php-8
# ==================================================================
# Swarm Cookbook - App Installer
#
# File:         src/apps/php-8
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
php-8::help()
{
	echo
	echo "${GOLD}====================================================================${RESET}"
	echo "${WHITE}PHP-8 HELP${RESET}"
	echo "${GOLD}====================================================================${RESET}"
	echo



	echo
	echo "${GOLD}====================================================================${RESET}"
	echo
}
#
# REQUIRES FUNCTION
#
php-8::requires() { echo; }
#
# INSTALLED FUNCTION
#
php-8::installed() { command -v php-8 > /dev/null; }
#
# INSTALL FUNCTION
#
php-8::install()
{
	echo
	echo "===================================================================="
	echo "INSTALLING PHP-8"
	echo "===================================================================="
	echo

	sudo apt install -y php8.1 php-sass php-cli php-pear
	sudo apt install -y php8.1-{amqp,cli,common,curl,fpm,gd,gnupg,imagick,imap,intl,mailparse,mbstring,memcached,mongodb,oauth,opcache,pgsql,psr,readline,redis,smbclient,ssh2,sqlite3,uploadprogress,xdebug,xml,yaml,zip}

	echo
	echo "DONE!"
	echo
}
#
# CONFIG FUNCTION
#
php-8::config()
{
	echo
	echo "===================================================================="
	echo "CONFIGURING PHP-8"
	echo "===================================================================="
	echo

	cp /etc/php/8.0/cli/php.ini /etc/php/8.0/cli/php.ini~

    sed -i '/^short_open_tag.*/c\short_open_tag=On' /etc/php/8.0/cli/php.ini
    sed -i '/^;highlight.*/c\highlight' /etc/php/8.0/cli/php.ini
    sed -i '/^error_reporting.*/c\error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE' /etc/php/8.0/cli/php.ini
    sed -i '/^enable_dl.*/c\enable_dl = On' /etc/php/8.0/cli/php.ini
    sed -i '/^;cgi.fix_pathinfo.*/c\cgi.fix_pathinfo=0' /etc/php/8.0/cli/php.ini
    sed -i '/^upload_max_filesize.*/c\upload_max_filesize = 25M' /etc/php/8.0/cli/php.ini
    sed -i "/^;date.timezone.*/c\date.timezone=\"${TIMEZONE}\"" /etc/php/8.0/cli/php.ini
    sed -i "/^memory_limit.*/c\memory_limit = 512M" /etc/php/8.0/cli/php.ini

	echo
	echo "DONE!"
	echo
}
#
# REMOVE FUNCTION
#
php-8::remove()
{
	echo
	echo "===================================================================="
	echo "UNINSTALLING PHP-8"
	echo "===================================================================="
	echo

	sudo apt purge -y --autoremove php8.1 php-sass
	sudo apt purge -y --autoremove php8.1-{amqp,cli,common,curl,fpm,gd,gnupg,imagick,imap,intl,mailparse,mbstring,memcached,mongodb,oauth,opcache,pgsql,psr,readline,redis,smbclient,ssh2,sqlite3,uploadprogress,xdebug,xml,yaml,zip}

	echo
	echo "DONE!"
	echo
}
#
# TEST FUNCTION
#
php-8::test()
{
	echo
	echo "===================================================================="
	echo "TESTING PHP-8"
	echo "===================================================================="
	echo

	echo

	echo
	echo "DONE!"
	echo
}
