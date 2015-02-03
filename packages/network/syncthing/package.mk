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

PKG_NAME="syncthing"
PKG_VERSION="0.10.21"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="http://syncthing.net/"
PKG_URL="https://github.com/syncthing/syncthing/releases/download/v${PKG_VERSION}/${PKG_NAME}-linux-${PKG_ARCH}v7-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="Open Source Continuous File Synchronization"
PKG_LONGDESC="Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
    mv ${BUILD}/${PKG_NAME}-linux-${PKG_ARCH}-v${PKG_VERSION} ${PKG_BUILD}
}

make_target() {
    : # nop
}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/bin
    cp -f ./${PKG_NAME} ${INSTALL}/usr/bin

    mkdir -p ${INSTALL}/usr/lib/systemd/system
    cp ./etc/linux-systemd/system/*.* ${INSTALL}/usr/lib/systemd/system

    mkdir -p ${INSTALL}/usr/config/
    cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/
}
