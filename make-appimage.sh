#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q prusa-slicer | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/192x192/apps/PrusaSlicer.png
export DESKTOP=/usr/share/applications/PrusaSlicer.desktop
export LOCALE_FIX=1
export PATH_MAPPING_HARDCODED='prusa-slicer'

# Deploy dependencies
quick-sharun \
	/usr/bin/prusa-slicer* \
	/usr/share/PrusaSlicer \
	/usr/lib/libnss_myhostname.so* \
	/usr/lib/libnss_mdns4_minimal.so* \
	/usr/lib/gio/modules/libgio*.so*
# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
