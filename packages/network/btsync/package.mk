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

PKG_NAME="btsync"
PKG_VERSION="1.4.106"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.getsync.com/"
PKG_URL="http://download.getsyncapp.com/endpoint/btsync/os/linux-${TARGET_ARCH}/track/stable"
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="Share directly from device to device. No cloud. No limits."
PKG_LONGDESC="Sync uses advanced peer-to-peer technology to share files between devices."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
    mkdir -p ${PKG_BUILD}
    tar xzf ${SOURCES}/${PKG_NAME}/stable -C ${PKG_BUILD}
}

make_target() {
    # Remove the 50 peers limit
    hexdump -ve '1/1 "%.2X"' btsync | sed -e 's/32005[2A]E3[0-9A-F]\{8\}/0000A0E10000A0E1/g' | xxd -r -p > btsync.patched
    mv btsync.patched btsync
}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/bin
    install ./${PKG_NAME} ${INSTALL}/usr/bin

    mkdir -p ${INSTALL}/etc/
    cp -rf ${PKG_DIR}/config/btsync.conf ${INSTALL}/etc/
}

post_install() {
  # add_user "username" "password" "userid" "groupid" "description" "home" "shell"
    add_user btsync     x          530      0       "btsync"  "/storage/.sync" "/bin/sh"

    enable_service btsync.service
}
