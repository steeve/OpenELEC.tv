################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="brcmfmac"
PKG_VERSION="3.19-rc1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="various"
PKG_SITE="https://wireless.wiki.kernel.org/en/users/Drivers/brcm80211"
PKG_URL=""
PKG_DEPENDS_TARGET="backports"
PKG_PRIORITY="optional"
PKG_SECTION="linux-drivers"
PKG_SHORTDESC="brcmfmac: FullMAC driver for Broadcom WiFi chips"
PKG_LONGDESC="brcmfmac: FullMAC driver for Broadcom WiFi chips"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  unset CC CFLAGS CXXFLAGS LDFLAGS MAKEFLAGS

  cd ../backports-*

  make clean defconfig-${PKG_NAME} modules V=1 \
       ARCH=$TARGET_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX \
       KLIB_BUILD=$(kernel_path) \
       KLIB=$INSTALL/lib/modules/$(get_module_dir)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
  cd ../backports-*
  find . -name \*.ko -exec cp -f {} $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME \;
}

post_install() {
  depmod -a -b $INSTALL $(get_module_dir)
}
