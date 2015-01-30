################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="plugin.video.pulsar"
PKG_VERSION="0.4.5"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="Non Commercial"
PKG_SITE="https://github.com/steeve/plugin.video.pulsar"
PKG_URL="https://github.com/steeve/$PKG_NAME/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.zip"
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="Pulsar Universal Streaming"
PKG_LONGDESC="Pulsar Universal Streaming"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.module"
PKG_AUTORECONF="no"
PKG_MAINTAINER="@steeve"

post_unpack() {
    mv $BUILD/$PKG_NAME $PKG_BUILD
}

make_target() {
    : # nop
}

makeinstall_target() {
    mkdir -p $INSTALL/usr/share/kodi/addons/
    cp -R $PKG_ADDON_ID $INSTALL/usr/share/kodi/addons/
}
