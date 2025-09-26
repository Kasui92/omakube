# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMAKUB_INSTALL/omakub-base.packages" | grep -v '^$')
sudo apt install -y "${packages[@]}"
