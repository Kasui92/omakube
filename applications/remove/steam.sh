#!/bin/bash

# Remove Steam from Flatpak
flatpak uninstall -y com.valvesoftware.Steam

# Also remove any Steam apt packages if they exist
sudo apt remove -y steam steam-launcher 2>/dev/null || true