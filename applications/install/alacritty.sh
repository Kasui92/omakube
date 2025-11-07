#!/bin/bash

sudo apt install -y alacritty

# Migrate alacritty config format if needed
alacritty migrate 2>/dev/null || true
