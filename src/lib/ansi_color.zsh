#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# ansi::color.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::color.zsh
# Author:       Ragdata
# Date:         18/08/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
if ! grep -q 'function' <<< "$(type ansi::cursor::restore)"; then loadLib ansi_cursor.zsh; fi
if ! grep -q 'function' <<< "$(type ansi::column)"; then loadLib ansi_format.zsh; fi
# ==================================================================
# VARIABLES
# ==================================================================
#
# ANSI VARIABLES
#
export ANSI_ESC=$'\033'
export ANSI_CSI="${ANSI_ESC}["
# ==================================================================
# FUNCTIONS
# ==================================================================
#
# ANSI FG COLOR FUNCTIONS ------------------------------------------
#
ansi::color()				{ printf '%s38;5;%sm' "$ANSI_CSI" "$1"; }
ansi::color::reset()		{ printf '%s0m' "$ANSI_CSI"; }
ansi::black()				{ printf '%s30m' "$ANSI_CSI"; }
ansi::blue()				{ printf '%s34m' "$ANSI_CSI"; }
ansi::cyan()				{ printf '%s36m' "$ANSI_CSI"; }
ansi::green()				{ printf '%s32m' "$ANSI_CSI"; }
ansi::magenta()				{ printf '%s35m' "$ANSI_CSI"; }
ansi::red()					{ printf '%s31m' "$ANSI_CSI"; }
ansi::white()				{ printf '%s37m' "$ANSI_CSI"; }
ansi::yellow()				{ printf '%s33m' "$ANSI_CSI"; }

ansi::rgb()					{ printf '%s38;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"; }
#
# ANSI HVY COLOR FUNCTIONS -----------------------------------------
#
ansi::hvy::black()			{ printf '%s90m' "$ANSI_CSI"; }
ansi::hvy::blue()			{ printf '%s94m' "$ANSI_CSI"; }
ansi::hvy::cyan()			{ printf '%s36m' "$ANSI_CSI"; }
ansi::hvy::green()			{ printf '%s92m' "$ANSI_CSI"; }
ansi::hvy::magenta()		{ printf '%s95m' "$ANSI_CSI"; }
ansi::hvy::red()			{ printf '%s91m' "$ANSI_CSI"; }
ansi::hvy::white()			{ printf '%s97m' "$ANSI_CSI"; }
ansi::hvy::yellow()			{ printf '%s93m' "$ANSI_CSI"; }
#
# ANSI BG COLOR FUNCTIONS ------------------------------------------
#
ansi::bg::reset()			{ printf '%s49m' "$ANSI_CSI"; }
ansi::bg::color()			{ printf '%s48;5;%sm' "$ANSI_CSI" "$1"; }
ansi::bg::rgb()				{ printf '%s48;2;%s;%s;%sm' "$ANSI_CSI" "$1" "$2" "$3"; }
ansi::bg::black()			{ printf '%s40m' "$ANSI_CSI"; }
ansi::bg::blue()			{ printf '%s44m' "$ANSI_CSI"; }
ansi::bg::cyan()			{ printf '%s46m' "$ANSI_CSI"; }
ansi::bg::green()			{ printf '%s42m' "$ANSI_CSI"; }
ansi::bg::magenta()			{ printf '%s45m' "$ANSI_CSI"; }
ansi::bg::red()				{ printf '%s41m' "$ANSI_CSI"; }
ansi::bg::white()			{ printf '%s47m' "$ANSI_CSI"; }
ansi::bg::yellow()			{ printf '%s43m' "$ANSI_CSI"; }
#
# ANSI HVY BG COLOR FUNCTIONS --------------------------------------
#
ansi::bg::hvy::black()		{ printf '%s100m' "$ANSI_CSI"; }
ansi::bg::hvy::blue()		{ printf '%s104m' "$ANSI_CSI"; }
ansi::bg::hvy::cyan()		{ printf '%s106m' "$ANSI_CSI"; }
ansi::bg::hvy::green()		{ printf '%s102m' "$ANSI_CSI"; }
ansi::bg::hvy::magenta()	{ printf '%s105m' "$ANSI_CSI"; }
ansi::bg::hvy::red()		{ printf '%s101m' "$ANSI_CSI"; }
ansi::bg::hvy::white()		{ printf '%s107m' "$ANSI_CSI"; }
ansi::bg::hvy::yellow()		{ printf '%s43m' "$ANSI_CSI"; }
# ------------------------------------------------------------------
# ansi::reset
# ------------------------------------------------------------------
# Reset all escape codes
# ------------------------------------------------------------------
ansi::reset()
{
	ansi::color::reset
	ansi::font::reset
	ansi::erase::display 2
	ansi::position "1;1"
	ansi::cursor::show
}
# ==================================================================
# FUNCTION ALIASES
# ==================================================================
#
# COLOR ALIASES ----------------------------------------------------
#
export BLACK="$(ansi::black)"
export BLUE="$(ansi::hvy::blue)"
export CYAN="$(ansi::cyan)"
export GOLD="$(ansi::yellow)"
export GREEN="$(ansi::green)"
export MAGENTA="$(ansi::hvy::magenta)"
export PURPLE="$(ansi::magenta)"
export PINK="$(ansi::hvy::red)"
export RED="$(ansi::red)"
export GREY="$(ansi::white)"
export WHITE="$(ansi::hvy::white)"
export YELLOW="$(ansi::hvy::yellow)"
# RESETS
export RESET="$(ansi::color::reset)"
export RESETALL="$(ansi::reset)"
#
# BG ALIASES -------------------------------------------------------
#
export BG_BLACK="$(ansi::bg::black)"
export BG_BLUE="$(ansi::bg::hvy::blue)"
export BG_CYAN="$(ansi::bg::cyan)"
export BG_GOLD="$(ansi::bg::yellow)"
export BG_GREEN="$(ansi::bg::green)"
export BG_MAGENTA="$(ansi::bg::hvy::magenta)"
export BG_PURPLE="$(ansi::bg::magenta)"
export BG_PINK="$(ansi::bg::hvy::red)"
export BG_RED="$(ansi::bg::red)"
export BG_GREY="$(ansi::bg::white)"
export BG_WHITE="$(ansi::bg::hvy::white)"
export BG_YELLOW="$(ansi::bg::hvy::yellow)"
# BG RESET
export BG_RESET="$(ansi::bg::reset)"
