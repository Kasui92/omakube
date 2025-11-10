#!/bin/bash

# Force migrate alacritty config format in first run
alacritty migrate 2>/dev/null || true