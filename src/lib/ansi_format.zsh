#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2034,SC2155
# ==================================================================
# ansi::format.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::format.zsh
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
if ! grep -q 'function' <<< "$(type ansi::blink 2> /dev/null)"; then loadLib ansi_effect.zsh; fi
# ==================================================================
# FUNCTIONS
# ==================================================================
ansi::column()				{ printf '%s%sG' "$ANSI_CSI" "${1-}"; }
ansi::column::relative()	{ printf '%s%sa' "$ANSI_CSI" "${1-}"; }
ansi::delete::chars()		{ printf '%s%sP' "$ANSI_CSI" "${1-}"; }
ansi::delete::lines()		{ printf '%s%sM' "$ANSI_CSI" "${1-}"; }
ansi::encircle()			{ printf '%s52m' "$ANSI_CSI"; }
ansi::erase::display()		{ printf '%s%sJ' "$ANSI_CSI" "${1-}"; }
ansi::erase::chars()		{ printf '%s%sX' "$ANSI_CSI" "${1-}"; }
ansi::erase::line()			{ printf '%s%sK' "$ANSI_CSI" "${1-}"; }
ansi::font()				{ printf '%s1%sm' "$ANSI_CSI" "${1-0}"; }
ansi::font::reset()			{ printf '%s10m' "$ANSI_CSI"; }
ansi::fraktur()				{ printf '%s20m' "$ANSI_CSI"; }
ansi::frame()				{ printf '%s51m' "$ANSI_CSI"; }
ansi::insert::chars()		{ printf '%s%s@' "$ANSI_CSI" "${1-}"; }
ansi::insert::lines()		{ printf '%s%sL' "$ANSI_CSI" "${1-}"; }
ansi::line()				{ printf '%s%sd' "$ANSI_CSI" "${1-}"; }
ansi::line::relative()		{ printf '%s%se' "$ANSI_CSI" "${1-}"; }
ansi::repeat()				{ printf '%s%sb' "$ANSI_CSI" "${1-}"; }
ansi::icon()				{ printf '%s1;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"; }
ansi::title()				{ printf '%s2;%s%s' "$ANSI_OSC" "${1-}" "$ANSI_ST"; }
ansi::tab()					{ printf '%s%sI' "$ANSI_CSI" "${1-}"; }
ansi::tab::back()			{ printf '%s%sZ' "$ANSI_CSI" "${1-}"; }
# ==================================================================
# FORMAT ALIASES
# ==================================================================
export BLINK="$(ansi::blink)"
export BLINKFAST="$(ansi::blink::rapid)"
export NOBLINK="$(ansi::no::blink)"
export BOLD="$(ansi::bold)"
export DOUBLELINE="$(ansi::underline::double)"
export FAINT="$(ansi::faint)"
export INVERSE="$(ansi::inverse)"
export NOINVERSE="$(ansi::no::inverse)"
export INVISIBLE="$(ansi::invisible)"
export ITALIC="$(ansi::italic)"
export NORMAL="$(ansi::normal)"
export OVERLINE="$(ansi::overline)"
export NOOVERLINE="$(ansi::no::overline)"
export OVERUNDER="$(ansi::overline)$(ansi::underline)"
export NOOVERUNDER="$(ansi::no::overline)$(ansi::no::underline)"
export PLAIN="$(ansi::plain)"
export STRIKE="$(ansi::strike)"
export NOSTRIKE="$(ansi::no::strike)"
export UNDERLINE="$(ansi::underline)"
export NOUNDERLINE="$(ansi::no::underline)"
export VISIBLE="$(ansi::visible)"
#
# PRINTABLE ALIASES ------------------------------------------------
#
export DEFAULT_Y="[${WHITE}Y${_0}/n]"
export DEFAULT_N="[y/${WHITE}N${_0}]"
