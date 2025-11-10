#!/bin/bash

sudo apt install -y alacritty

# Migrate alacritty config format if needed
alacritty migrate 2>/dev/null || true

# Create custom desktop entry with X-TerminalArg* keys
cat > ~/.local/share/applications/Alacritty.desktop << EOF
[Desktop Entry]
Type=Application
TryExec=alacritty
Exec=alacritty
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;
Name=Alacritty
GenericName=Terminal
Comment=A fast, cross-platform, OpenGL terminal emulator
StartupNotify=true
StartupWMClass=Alacritty
Actions=New;
X-TerminalArgExec=-e
X-TerminalArgAppId=--class=
X-TerminalArgTitle=--title=
X-TerminalArgDir=--working-directory=

[Desktop Action New]
Name=New Terminal
Exec=alacritty
EOF

# Add to xdg-terminals if xdg-terminal-exec is installed (only for noble users)
mkdir -p ~/.local/share/xdg-terminals
cp ~/.local/share/applications/Alacritty.desktop ~/.local/share/xdg-terminals/