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

PKG_NAME="backports"
PKG_VERSION="3.19-rc1"
PKG_URL="http://www.kernel.org/pub/linux/kernel/projects/$PKG_NAME/stable/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION-1.tar.xz"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kernel.org"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain xz:host linux"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="drivers"
PKG_SHORTDESC="backports: The linux driver backports for older kernels"
PKG_LONGDESC="Backports provide drivers released on newer kernels backported for usage on older kernels."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  mv $BUILD/$PKG_NAME-$PKG_VERSION-1 $BUILD/$PKG_NAME-$PKG_VERSION
}

make_target() {
  unset CC CFLAGS CXXFLAGS LDFLAGS

  make defconfig-brcmfmac V=1 \
       ARCH=$TARGET_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX \
       KLIB_BUILD=$(kernel_path) \
       KLIB=$INSTALL/lib/modules/$(get_module_dir)

  sed -i -e "s|# CPTCFG_BRCM_TRACING is not set|CPTCFG_BRCM_TRACING=y|" \
         -e "s|# CPTCFG_BRCMDBG is not set|CPTCFG_BRCMDBG=y|" \
         .config

  make V=1 \
       ARCH=$TARGET_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX \
       KLIB_BUILD=$(kernel_path) \
       KLIB=$INSTALL/lib/modules/$(get_module_dir)
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
  find . -name \*.ko -exec cp -f {} $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME \;
}

post_install() {
  depmod -a -b $INSTALL $(get_module_dir)
}
