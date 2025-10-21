#!/bin/bash

sudo apt remove --purge -y "libreoffice*"
sudo apt -y clean
sudo apt -y autoremove