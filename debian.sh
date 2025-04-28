#!/bin/bash

#########################
# Author: Elie ROCAMORA #
# Date:   28/04/2025    #
#########################

function install_few_tools {
        apt update && apt install -y ca-certificates curl gpg
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb && apt install -y ./fastfetch-linux-amd64.deb && rm ./fastfetch-linux-amd64.deb
}

function install_sudo {
        apt install -y sudo
        read -p "User: " user
        echo -e "\n$user ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
}

function install_fish {
        apt install -y fish
        chsh -s /usr/bin/fish
        /usr/bin/fish -c 'set -U fish_greeting'
        echo -e "\nabbr ipconfig 'ip -c -br a|grep -E \"ens|eth\"'" >> ~/.config/fish/config.fish
}

function install_motd {
        curl -s https://raw.githubusercontent.com/Elieroc/automation/refs/heads/main/ressources/custom-motd -o /etc/motd/99-custom
}

function main {
        install_few_tools
        install_sudo
        install_fish
        install_motd
}

main
