#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm prusa-slicer

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
export PRE_BUILD_CMDS='sed -i "s|;wxWidgets||g" ./PKGBUILD
sed -i "/B deps_\${pkgver}/a -DDEP_WX_GTK3=ON \\\\" ./PKGBUILD'
make-aur-package --archlinux-pkg "prusa-slicer.git"

# If the application needs to be manually built that has to be done down here
