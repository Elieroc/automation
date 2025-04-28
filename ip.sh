#!/bin/bash

set_static_ip() {
    read -p "Static IP/Mask (press enter to skip): " ip
    read -p "Gateway (press enter to skip): " gateway
    if [[ -n "$ip" && -n "$gateway" ]]; then
        interface=$(ip route | awk '/default/ {print $5}')
        cat > /etc/network/interfaces.d/$interface.cfg <<EOF
allow-hotplug $interface
iface $interface inet static
    address $ip
    gateway $gateway
EOF
        systemctl restart networking
    fi
}

set_dns() {
    read -p "DNS server (press enter to skip): " dns
    if [[ -n "$dns" ]]; then
        echo "nameserver $dns" > /etc/resolv.conf
    fi
}

set_hostname() {
    read -p "Hostname (press enter to skip): " hostname
    if [[ -n "$hostname" ]]; then
        echo "$hostname" > /etc/hostname
        hostnamectl set-hostname "$hostname"
    fi
}

set_static_ip
set_dns
set_hostname
