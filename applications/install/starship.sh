#!/bin/bash

cd /tmp
curl -sLo starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz"
tar -xf starship.tar.gz starship
install -m 755 starship ~/.local/bin
rm starship.tar.gz starship
cd -