#!/bin/bash

set -ouex pipefail

# Install packages

## Add COPR for Hyprland packages
dnf5 -y copr enable solopasha/hyprland

# Install rpmfusion repositories
rpm-ostree install \
	https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm \
	https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

## Install packages from the default list
grep -v '^#' /ctx/packages/default.packages | xargs dnf5 install -y \
  && dnf5 clean all
