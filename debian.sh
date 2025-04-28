#!/bin/bash

#########################
# Author: Elie ROCAMORA #
# Date:   28/04/2025    #
#########################

function conf_few_tools {
        apt update && apt install -y curl gpg
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

#conf_few_tools
#conf_sudo
#conf_fish
#conf_motd
