#!/bin/bash

echo "Enable UFW systemd service for existing installations"

if omarchy-cmd-present ufw; then
    if sudo ufw status | grep -q "Status: active\|22/tcp\|53317"; then
        if ! systemctl is-enabled ufw >/dev/null 2>&1; then
            sudo systemctl enable ufw --now
            echo "UFW systemd service enabled"
        fi
    fi
fi


echo "Fix DHCP DNS to allow VPN DNS override"

if [ -f /etc/systemd/resolved.conf ]; then
  if grep -q "^DNS=$" /etc/systemd/resolved.conf && grep -q "^FallbackDNS=$" /etc/systemd/resolved.conf; then
    sudo sed -i '/^DNS=$/d; /^FallbackDNS=$/d' /etc/systemd/resolved.conf
    sudo systemctl restart systemd-resolved
  fi
fi

echo "Enable mDNS resolution for existing Avahi installations"

if systemctl is-enabled avahi-daemon.service >/dev/null 2>&1; then
  if ! grep -q "mdns_minimal" /etc/nsswitch.conf; then
    sudo sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns/' /etc/nsswitch.conf
  fi
fi