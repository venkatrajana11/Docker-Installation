#!/bin/bash

#Script to see Docker & Docker compose installed on the server. If not, Script will install the Docker and Docker Compose.
#Once done, Need to exit and relogin to the server.

DOCKER_INSTALLED=false
DOCKER_COMPOSE_INSTALLED=false

Check_Docker_Installed() {
if [ -x "$(command -v docker -v)" ]; then
    DOCKER_INSTALLED=true
fi
}

Check_Docker_Compose_Installed() {
if [ -x "$(command -v docker-compose -v)" ]; then
    DOCKER_COMPOSE_INSTALLED=true
fi
}

Docker_Installation() {
    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update -y
    apt-cache policy docker-ce
    sudo apt install docker-ce -y
    sudo usermod -aG docker ${USER}
}

Docker_Compose_Installation() {
    sudo apt install docker-compose -y
}

Check_Docker_Installed
Check_Docker_Compose_Installed

if [[ $DOCKER_INSTALLED == true && $DOCKER_COMPOSE_INSTALLED == true ]]; then
    echo -e "\033[1m\033[34mDocker and Docker Compose are already Installed\033[0m"
else
    read -p "Do you want to install Docker and Docker compose (Y/N)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[yY]$ ]]; then
        echo
        echo -e "\033[1m\033[34mINSTALLING DOCKER...\033[0m"
        sleep 2;
        Docker_Installation
        echo
        echo -e "\033[1m\033[34mINSTALLING DOCKER-COMPOSE...\033[0m"
        sleep 2;
        Docker_Compose_Installation
        echo
        echo -e "\033[1m\033[34mDOCKER & DOCKER COMPOSE ARE SUCCESSFULLY INSTALLED!!!...PLEASE EXIT AND RE-LOGIN....\033[0m"
    else
        echo -e "\033[1m\033[31mInstallation Cancelled...\033[0m"
    fi
fi
