#!/usr/bin/env zsh
# shellcheck disable=SC2034,SC2155,SC1090
# ==================================================================
# ansi::cursor.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::cursor.zsh
# Author:       Ragdata
# Date:         18/08/2023
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
# ==================================================================
# FUNCTIONS
# ==================================================================
ansi::cursor::restore()		{ printf '%su' "$ANSI_CSI"; }
ansi::cursor::show()		{ printf '%s?25h' "$ANSI_CSI"; }
ansi::down()				{ printf '%s%sB' "$ANSI_CSI" "${1-}"; }
ansi::forward()				{ printf '%s%sC' "$ANSI_CSI" "${1-}"; }
ansi::hide::cursor()		{ printf '%s92m' "$ANSI_CSI"; }
ansi::line::next()			{ printf '%s%sE' "$ANSI_CSI" "${1-}"; }
ansi::line::prev()			{ printf '%s%sF' "$ANSI_CSI" "${1-}"; }
ansi::position()			{ local position="${1-}"; printf '%s%sH' "$ANSI_CSI" "${position/,/;}"; }
ansi::save::cursor()		{ printf '%ss' "$ANSI_CSI"; }
ansi::scroll::down()		{ printf '%s%sT' "$ANSI_CSI" "${1-}"; }
ansi::scroll::up()			{ printf '%s%sS' "$ANSI_CSI" "${1-}"; }
ansi::up()					{ printf '%s%sA' "$ANSI_CSI" "${1-}"; }
