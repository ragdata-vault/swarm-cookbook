#!/usr/bin/env zsh
# shellcheck disable=SC1090,SC2034,SC2155
# ==================================================================
# ansi::misc.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::misc.zsh
# Author:       Ragdata
# Date:         18/08/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! typeset -f loadLib > /dev/null; then
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
if ! typeset -f ansi::color > /dev/null; then loadLib ansi_color.zsh; fi
# ==================================================================
# FUNCTIONS
# ==================================================================
ansi::reset::attributes()	{ printf '%s22;23;24;25;27;28;29;54;55m' "$ANSI_CSI"; }
ansi::reset::fg()			{ printf '%s39m' "$ANSI_CSI"; }
# ------------------------------------------------------------------
# ansi::test::aliases
# ------------------------------------------------------------------
# @description Test ANSI aliases and display and example of each alias
# ------------------------------------------------------------------
ansi::test::aliases()
{
	clear
	echoGold "=================================================================="
	echoGold "COLOR TEST"
	echoGold "=================================================================="
	echo
	echoBlack "echoBlack"
	echoPink "echoPink"
	echoRed "echoRed"
	echoGreen "echoGreen"
	echoGold "echoGold"
	echoYellow "echoYellow"
	echoBlue "echoBlue"
	echoMagenta "echoMagenta"
	echoPurple "echoPurple"
	echoCyan "echoCyan"
	echoGrey "echoGrey"
	echoWhite "echoWhite"
	echoDebug "echoDebug"
	echoDefault "echoDefault"
	echoError "echoError"
	echoInfo "echoInfo"
	echoSuccess "echoSuccess"
	echoWarning "echoWarning"
	echo
	echoGold "=================================================================="
	echoGold "BACKGROUND TEST"
	echoGold "=================================================================="
	echo
	echo "${BG_BLACK}  ${WHITE}BG BLACK  ${RESET}${BG_RESET}"
	echo "${BG_PINK}  ${BLACK}BG PINK  ${RESET}${BG_RESET}"
	echo "${BG_RED}  ${BLACK}BG RED  ${RESET}${BG_RESET}"
	echo "${BG_GREEN}  ${BLACK}BG GREEN  ${RESET}${BG_RESET}"
	echo "${BG_GOLD}  ${BLACK}BG GOLD  ${RESET}${BG_RESET}"
	echo "${BG_YELLOW}  ${BLACK}BG YELLOW  ${RESET}${BG_RESET}"
	echo "${BG_MAGENTA}  ${BLACK}BG MAGENTA  ${RESET}${BG_RESET}"
	echo "${BG_PURPLE}  ${BLACK}BG PURPLE  ${RESET}${BG_RESET}"
	echo "${BG_CYAN}  ${BLACK}BG CYAN  ${RESET}${BG_RESET}"
	echo "${BG_GREY}  ${BLACK}BG GREY  ${RESET}${BG_RESET}"
	echo "${BG_WHITE}  ${BLACK}BG WHITE  ${RESET}${BG_RESET}"
	echo
	echoGold "=================================================================="
	echoGold "STYLE TEST"
	echoGold "=================================================================="
	echo
	echo "${BLINK}BLINK${NOBLINK}"
	echo "${BLINKFAST}BLINKFAST${NOBLINK}"
	echo "${BOLD}BOLD${NORMAL}"
	echo "${DOUBLELINE}DOUBLELINE${NOUNDERLINE}"
	echo "${FAINT}FAINT${NORMAL}"
	echo "${INVERSE}  INVERSE  ${NOINVERSE}"
	echo "${INVISIBLE}INVISIBLE${VISIBLE}"
	echo "${ITALIC}ITALIC${PLAIN}"
	echo "${OVERLINE}OVERLINE${NOOVERLINE}"
	echo "${OVERUNDER}OVERUNDER${NOOVERUNDER}"
	echo "${STRIKE}STRIKE${NOSTRIKE}"
	echo "${UNDERLINE}UNDERLINE${NOUNDERLINE}"
	echo
}
