#!/bin/bash

set -ouex pipefail

# Install eza

## For now, this is required, as long as eza won't be available in fedora 42
## Maybe switch to a COPR in the future

LATEST_VERSION=$(curl -s https://api.github.com/repos/eza-community/eza/releases/latest | jq -r .tag_name)
DOWNLOAD_URL="https://github.com/eza-community/eza/releases/download/${LATEST_VERSION}/eza_x86_64-unknown-linux-gnu.tar.gz"

wget "$DOWNLOAD_URL" -O /tmp/eza.tar.gz && \
  tar -xzf /tmp/eza.tar.gz -C /tmp && \
  mv /tmp/eza /usr/bin/eza && \
  eza --version

# Install grimblast

wget https://raw.githubusercontent.com/hyprwm/contrib/refs/heads/main/grimblast/grimblast -O /usr/bin/grimblast

# Install chezmoi

sh -c "$(curl -fsLS get.chezmoi.io)"

# Install bat

# mkdir ~/xxh && cd ~/xxh
# wget -O xxh https://github.com/xxh/xxh/releases/download/0.8.12/xxh-x86_64.AppImage
# chmod +x xxh && ./xxh
