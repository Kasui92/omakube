#!/bin/bash

# Set links for Nautilius action icons
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-previous-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-previous-symbolic.svg
sudo ln -snf /usr/share/icons/Adwaita/symbolic/actions/go-next-symbolic.svg /usr/share/icons/Yaru/scalable/actions/go-next-symbolic.svg
sudo gtk-update-icon-cache /usr/share/icons/Yaru

# Setup theme links
if [ -d ~/.config/omakub/themes ]; then
  rm -rf ~/.config/omakub/themes
fi
mkdir -p ~/.config/omakub/themes
for f in ~/.local/share/omakub/themes/*; do ln -s "$f" ~/.config/omakub/themes/; done

# Set initial theme
mkdir -p ~/.config/omakub/current
ln -snf ~/.config/omakub/themes/tokyo-night ~/.config/omakub/current/theme
ln -snf $(find "$HOME/.config/omakub/current/theme/backgrounds/" -type f | head -n 1) "$HOME/.config/omakub/current/background"

# Set specific app links for current theme
[ -e ~/.config/nvim/lua/plugins/theme.lua ] && rm ~/.config/nvim/lua/plugins/theme.lua
ln -snf ~/.config/omakub/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

[ -e ~/.config/btop/themes/current.theme ] && rm ~/.config/btop/themes/current.theme
mkdir -p ~/.config/btop/themes
ln -snf ~/.config/omakub/current/theme/btop.theme ~/.config/btop/themes/current.theme

[ -e ~/.config/zellij/themes/current.kdl ] && rm ~/.config/zellij/themes/current.kdl
mkdir -p ~/.config/zellij/themes
ln -snf ~/.config/omakub/current/theme/zellij.kdl ~/.config/zellij/themes/current.kdl
