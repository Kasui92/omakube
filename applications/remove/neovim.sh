#!/bin/bash

sudo apt purge -y neovim neovim-runtime
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim