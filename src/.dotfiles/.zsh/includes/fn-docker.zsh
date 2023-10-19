#!/usr/bin/env zsh

# ==================================================================
# fn-docker.zsh
# ==================================================================
# Swarm Cookbook Code Snippet
#
# File:         fn-docker.zsh
# Author:       Ragdata
# Date:         22/08/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
# DEPENDENCIES
# ==================================================================

# ==================================================================
# FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# tail
# ------------------------------------------------------------------
tail()
{
    if [[ "$#" -lt 1 ]]; then echoError "ERROR: Insufficient arguments passed"; return 1; fi

    tail -50 /var/log/bb/"$1"
}
# ------------------------------------------------------------------
# logs
# ------------------------------------------------------------------
logs()
{
    if [[ "$#" -lt 1 ]]; then echoError "ERROR: Insufficient arguments passed"; return 1; fi

    docker logs "$1"
}
# ------------------------------------------------------------------
# follow
# ------------------------------------------------------------------
follow()
{
    if [[ "$#" -lt 1 ]]; then echoError "ERROR: Insufficient arguments passed"; return 1; fi

    docker logs --follow "$1"
}
# ==================================================================
# GCB-ALIASES
# ==================================================================
alias dklc='docker ps -l'  																								# List last Docker container
alias dklcid='docker ps -l -q'  																						# List last Docker container ID
alias dklcip='docker inspect -f "{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}" $(docker ps -l -q)'  # Get IP of last Docker container
alias dkps='docker ps'  																								# List running Docker containers
alias dkpsa='docker ps -a'  																							# List all Docker containers
alias dki='docker images'  																								# List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'  																			# Delete all Docker containers
alias dkrmui='docker images -q -f dangling=true |xargs -r docker rmi'  													# Delete all untagged Docker images
alias dkelc='docker exec -it `dklcid` bash' 																			# Enter last container (works with Docker 1.3 and above)
alias dsls='docker stack ls'																							# List all Stack Members
# ==================================================================
# STACK FUNCTIONS
# ==================================================================
# ------------------------------------------------------------------
# dsd
# ------------------------------------------------------------------
dsd()
{
	local stack="${1}.docker-compose.yml"

	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	[[ ! -f "$stack" ]] && { echo "ERROR :: File '$stack' Not Found!"; return 1; }

	docker stack deploy -c "$stack" "$1"
}
# ------------------------------------------------------------------
# dsrm
# ------------------------------------------------------------------
dsrm()
{
	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	docker stack rm "$1"
}
# ------------------------------------------------------------------
# dsps
# ------------------------------------------------------------------
dsps()
{
	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	docker stack ps "$1"
}
# ------------------------------------------------------------------
# dss
# ------------------------------------------------------------------
dss()
{
	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	docker stack services "$1"
}
# ------------------------------------------------------------------
# dsi
# ------------------------------------------------------------------
dsi()
{
	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	if [[ -z "$2" ]]; then
		docker service inspect --pretty "$1"
	else
		docker service inspect "$1"
	fi
}
# ------------------------------------------------------------------
# dssrm
# ------------------------------------------------------------------
dssrm()
{
	[[ "$#" -lt 1 ]] && { echo "ERROR :: Missing Argument!"; return 1; }

	docker service rm "$1"
}
