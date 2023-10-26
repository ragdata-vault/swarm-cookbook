#!/usr/bin/env zsh
# shellcheck disable=SC2155
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
# regexCC
# ==================================================================
regex::isCC()			{ regexCC isCC; }
regex::isAMEX()			{ regexCC isAMEX; }
regex::isDINERS()		{ regexCC isDINERS; }
regex::isDISCOVER()		{ regexCC isDISCOVER; }
regex::isJCB()			{ regexCC isJCB; }
regex::isMCARD()		{ regexCC isMCARD; }
regex::isVISA()			{ regexCC isVISA; }
# ==================================================================
# regexDate
# ==================================================================
regex::isDate()			{ regexDate isDate; }
regex::isDATETIME()		{ regexDate isDATETIME; }
regex::isDATEDMY()		{ regexDate isDATEDMY; }
regex::isDATEMDY()		{ regexDate isDATEMDY; }
regex::isDATEYMD()		{ regexDate isDATEYMD; }
# ==================================================================
# regexDocker
# ==================================================================
regex::isDOCKJOIN()		{ regexDocker isDOCKJOIN; }
regex::isSWMKEY()		{ regexDocker isSWMKEY; }
# ==================================================================
# regexGeneral
# ==================================================================
regex::isVARNAME()		{ regexGeneral isVARNAME; }
regex::isDBNAME()		{ regexGeneral isDBNAME; }
regex::isPATH()			{ regexGeneral isPATH; }
regex::isLOC()			{ regexGeneral isLOC; }
regex::isUSERPASS()		{ regexGeneral isUSERPASS; }
regex::isPASS()			{ regexGeneral isPASS; }
# ==================================================================
# regexNetwork
# ==================================================================
regex::isURL()			{ regexNetwork isURL; }
regex::isFQDN()			{ regexNetwork isFQDN; }
regex::isHOST()			{ regexNetwork isHOST; }
regex::isPORT()			{ regexNetwork isPORT; }
regex::isSSH()			{ regexNetwork isSSH; }
regex::isIPv4()			{ regexNetwork isIPv4; }
regex::isIPv6()			{ regexNetwork isIPv6; }
regex::isMAC()			{ regexNetwork isMAC; }
regex::isEMAIL()		{ regexNetwork isEMAIL; }
# ==================================================================
# regexNumeric
# ==================================================================
regex::isINT()			{ regexNumeric isINT; }
regex::isFLOAT()		{ regexNumeric isFLOAT; }
regex::isDECIMAL()		{ regexNumeric isDECIMAL; }
regex::isBOOL()			{ regexNumeric isBOOL; }
# ==================================================================
# regexOptions
# ==================================================================
regex::isOPT()			{ regexOptions isOPT; }
regex::isOPTNOVAL()		{ regexOptions isOPTNOVAL; }
regex::isOPTVAL()		{ regexOptions isOPTVAL; }
regex::isSOPT()			{ regexOptions isSOPT; }
regex::isSOPTNOVAL()	{ regexOptions isSOPTNOVAL; }
regex::isSOPTVAL()		{ regexOptions isSOPTVAL; }
regex::isLOPT()			{ regexOptions isLOPT; }
regex::isLOPTNOVAL()	{ regexOptions isLOPTNOVAL; }
regex::isLOPTVAL()		{ regexOptions isLOPTVAL; }
# ==================================================================
# regexResponse
# ==================================================================
regex::RESP()			{ regexResponse RESP; }
regex::AFFIRM()			{ regexResponse AFFIRM; }
regex::NEGAT()			{ regexResponse NEGAT; }
