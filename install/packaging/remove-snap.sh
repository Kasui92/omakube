#!/bin/bash

# Remove snap packages if they exist
remove_snaps() {
    local max_attempts=5
    local attempt=0

    while [ $attempt -lt $max_attempts ]; do
        # Get current snap packages (excluding header line and snapd initially)
        local snap_pkgs=$(snap list 2>/dev/null | awk 'NR>1 && $1!="snapd" {print $1}')

        # If no packages found, try to remove snapd itself
        if [ -z "$snap_pkgs" ]; then
            snap_pkgs=$(snap list 2>/dev/null | awk 'NR>1 && $1=="snapd" {print $1}')
        fi

        # If no packages left, we're done
        if [ -z "$snap_pkgs" ]; then
            break
        fi

        # Remove packages in batch
        for pkg in $snap_pkgs; do
            sudo snap remove --purge "$pkg" 2>/dev/null || true
        done

        ((attempt++))
        # Small delay to let snap system settle
        sleep 1
    done
}

# Check if snap is installed
if command -v snap >/dev/null 2>&1; then
    remove_snaps >/dev/null

    # Remove snapd and gnome-software-plugin-snap
    sudo apt remove --purge snapd gnome-software-plugin-snap -y >/dev/null 2>&1
    sudo apt clean
    sudo rm -rf /var/cache/snapd/ /var/lib/snapd/ /var/snap/ /snap /etc/snap >/dev/null 2>&1
    rm -rf ~/snap >/dev/null 2>&1

    sudo apt-mark hold snapd >/dev/null 2>&1
fi
