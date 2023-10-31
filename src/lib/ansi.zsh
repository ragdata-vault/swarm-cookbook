#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2034,SC2155
# ==================================================================
# ansi.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi.zsh
# Author:       Ragdata
# Date:         19/10/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! grep -q 'function' <<< "$(type loadLib 2> /dev/null)"; then
	loadLib()
	{
		local file="${1:-}"

		if [[ "${1:0:1}" == "/" ]] && [[ -f "$file" ]]; then
			source "$file"
		elif [[ -f /usr/local/lib/"$file" ]]; then
			source /usr/local/lib/"$file"
		elif [[ -f "$REPO"/src/lib/"$file" ]]; then
			source "$REPO"/src/lib/"$file"
		else
			echo "Library File '$file' Not Found!"
			exit 1
		fi
	}
fi
if ! grep -q 'function' <<< "$(type ansi::color 2> /dev/null)"; then loadLib ansi_color.zsh; fi
if ! grep -q 'function' <<< "$(type ansi::cursor::restore 2> /dev/null)"; then loadLib ansi_cursor.zsh; fi
if ! grep -q 'function' <<< "$(type ansi::blink 2> /dev/null)"; then loadLib ansi_effect.zsh; fi
if ! grep -q 'function' <<< "$(type ansi::column 2> /dev/null)"; then loadLib ansi_format.zsh; fi
if ! grep -q 'function' <<< "$(type ansi::reset::attributes 2> /dev/null)"; then loadLib ansi_misc.zsh; fi
if ! grep -q 'function' <<< "$(type historyStats 2> /dev/null)"; then loadLib common.zsh; fi
if ! grep -q 'function' <<< "$(type regex::isCC 2> /dev/null)"; then loadLib regex_aliases.zsh; fi
