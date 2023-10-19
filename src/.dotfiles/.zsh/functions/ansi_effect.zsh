#!/usr/bin/env zsh
# shellcheck disable=SC2155
# ==================================================================
# ansi::effect.zsh
# ==================================================================
# Swarm Cookbook Function Library
#
# File:         ansi::effect.zsh
# Author:       Ragdata
# Date:         18/08/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================
[[ -z "$ANSI_CSI" ]] && source "$ZSHDIR"/functions/ansi_color.zsh
# ==================================================================
# FUNCTIONS
# ==================================================================
ansi::blink() 				{ printf '%s5m' "$ANSI_CSI"; }
ansi::blink::rapid()		{ printf '%s6m' "$ANSI_CSI"; }
ansi::bold()				{ printf '%s1m' "$ANSI_CSI"; }
ansi::faint()				{ printf '%s2m' "$ANSI_CSI"; }
ansi::inverse()				{ printf '%s7m' "$ANSI_CSI"; }
ansi::invisible()			{ printf '%s8m' "$ANSI_CSI"; }
ansi::italic()				{ printf '%s3m' "$ANSI_CSI"; }
ansi::normal()				{ printf '%s22m' "$ANSI_CSI"; }
ansi::no::blink()			{ printf '%s25m' "$ANSI_CSI"; }
ansi::no::border()			{ printf '%s54m' "$ANSI_CSI"; }
ansi::no::inverse()			{ printf '%s27m' "$ANSI_CSI"; }
ansi::no::overline()		{ printf '%s55m' "$ANSI_CSI"; }
ansi::no::strike()			{ printf '%s29m' "$ANSI_CSI"; }
ansi::no::underline()		{ printf '%s24m' "$ANSI_CSI"; }
ansi::overline()			{ printf '%s53m' "$ANSI_CSI"; }
ansi::plain()				{ printf '%s23m' "$ANSI_CSI"; }
ansi::strike()				{ printf '%s9m' "$ANSI_CSI"; }
ansi::underline()			{ printf '%s4m' "$ANSI_CSI"; }
ansi::underline::double()	{ printf '%s21m' "$ANSI_CSI"; }
ansi::visible()				{ printf '%s28m' "$ANSI_CSI"; }
