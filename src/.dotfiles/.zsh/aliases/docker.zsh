#!/usr/bin/env zsh

# ==================================================================
# docker.zsh
# ==================================================================
# Bash-Bits Modular Bash Library File
#
# File:         docker.zsh
# Author:       Ragdata
# Date:         17/09/2023
# License:      MIT License
# Copyright:    Copyright © 2023 Darren (Ragdata) Poulton
# ==================================================================
alias dklc='docker ps -l'                               # List last docker container
alias dklcid='docker ps -l -q'                          # List last docker container id
alias dklcip='docker inspect -f "{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}" $(docker ps -l -q)'  # Get IPs of last docker container
alias dkps='docker ps'                                  # List running docker containers
alias dkpsa='docker ps -a'                              # List all docker containers
alias dki='docker images'                               # List docker images
alias dkrmac='docker rm $(docker ps -a -q)'             # Delete all docker containers
alias dkrmlc='docker-remove-most-recent-container'      # Delete last docker container
alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'  # Delete all untagged docker images
alias dkrmall='docker-remove-stale-assets'              # Delete all untagged images and exited containers
alias dkrmli='docker-remove-most-recent-image'          # Delete most recent docker image
alias dkrmi='docker-remove-images'                      # Delete images for supplied IDs or all if no IDs are passed as arguments
alias dkideps='docker-image-dependencies'               # Output a graph of image dependencies using Graphiz
alias dkre='docker-runtime-environment'                 # List environmental variables by supplied image ID
alias dkelc='docker exec -it `dklcid` bash'             # Enter last container
alias dkstat='systemctl status docker'

alias lzd='lazydocker'
