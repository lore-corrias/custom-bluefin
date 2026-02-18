#!/bin/bash

set -ouex pipefail

# Enable default services

## Dotfiles installation oneshot service
systemctl --global enable install-dotfiles.service

## Docker/podman services
systemctl enable podman.socket
systemctl enable podman
systemctl enable podman-auto-update.timer
systemctl --global enable podman-auto-update.timer

## Rpm-ostree automatic updates
systemctl enable rpm-ostreed-automatic.timer

## Enable Mullvad service
systemctl enable mullvad-daemon

# Linking oneshot systemd units to multi-user.target.wants
ln -sf /usr/lib/systemd/user/install-dotfiles.service /etc/systemd/user/default.target.wants/install-dotfiles.service
ln -sf /usr/lib/systemd/user/setup-flatpak.service /etc/systemd/user/default.target.wants/setup-flatpak.service

# Adding services for flatpak update with timer
ln -sf /usr/lib/systemd/user/flatpak-user-update.service /etc/systemd/user/default.target.wants/flatpak-user-update.service
ln -sf /usr/lib/systemd/user/flatpak-user-update.timer /etc/systemd/user/default.target.wants/flatpak-user-update.timer
