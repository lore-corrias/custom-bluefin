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

# Install mullvad

rm /opt && \
  mkdir -p /etc/apparmor.d/
  mkdir /opt && \
  dnf install -y mullvad-vpn && \
  mkdir -p /usr/lib/opt && \
  mv "/opt/Mullvad VPN" /usr/lib/opt/ && \
  rm -rf /opt && \
  ln -s var/opt /opt && \
  # Create a tmpfiles.d config to link /var/opt/Mullvad VPN -> /usr/lib/opt/Mullvad VPN on boot
  echo "L /var/opt/Mullvad\x20VPN - - - - /usr/lib/opt/Mullvad\x20VPN" > /usr/lib/tmpfiles.d/mullvad-vpn.conf

# dnf install -y \
#     cpio \
#     dbus-libs \
#     libnotify \
#     libappindicator-gtk3 \
#     nss \
#     alsa-lib \
#     && dnf download mullvad-vpn \
#     && dnf clean all
#
# mkdir -p /tmp/mullvad-install && \
#     cd /tmp/mullvad-install && \
#     dnf download mullvad-vpn && \
#     rpm2cpio MullvadVPN-*.rpm | cpio -idmv && \
#     cp -r opt/Mullvad\ VPN /var/opt/ && \
#     cp -r usr/* /usr/ && \
#     cd / && \
#     rm -rf /tmp/mullvad-install && \
#     ls -la /var/opt/ && \

