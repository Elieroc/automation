#!/bin/bash

#########################
# Author: Elie ROCAMORA #
# Date:   28/04/2025    #
#########################

function conf_few_tools {
        apt update && apt install -y ca-certificates curl gpg
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb && apt install -y ./fastfetch-linux-amd64.deb && rm ./fastfetch-linux-amd64.deb
}

function conf_sudo {
        apt install -y sudo
        read -p "User: " user
        echo -e "\n$user ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
}

function conf_fish {
        apt install -y fish
        chsh -s /usr/bin/fish
        /usr/bin/fish -c 'set -U fish_greeting'
        echo -e "\nabbr ipconfig 'ip -c -br a|grep -E \"ens|eth\"'" >> ~/.config/fish/config.fish
}

function conf_motd {
        curl https://..../custom-motd -o /etc/motd/99-custom
}

function conf_docker {
        apt install -y ca-certificates && install -m 0755 -d /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && chmod a+r /etc/apt/keyrings/docker.gpg && echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}

function main {

        read -p "Install Docker ? (y/n): " res
        if [[ "$res" == "y" || "$res" == "Y" ]]; then conf_docker; fi

        #conf_few_tools
        #conf_sudo
        #conf_fish
        #conf_motd
}

main
