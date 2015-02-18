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

PKG_NAME="kodi-theme-PersonaMod"
PKG_ADDON_ID="skin.personamod"
PKG_VERSION="9e68a214608845fb2c6aa9f9296e0110f1d992ac"
PKG_REV="4"
PKG_ARCH="any"
PKG_LICENSE="Creative Commons"
PKG_SITE="https://github.com/steeve/skin.personamod/"
PKG_URL="https://github.com/steeve/${PKG_ADDON_ID}/archive/${PKG_VERSION}.zip"
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="A new skin for XBMC Gotham"
PKG_LONGDESC="A new skin for XBMC Gotham"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.gui.skin"
PKG_AUTORECONF="no"
PKG_MAINTAINER="steeve"

unpack() {
    $SCRIPTS/extract $PKG_NAME "$PKG_VERSION*.zip"     $BUILD
}

post_unpack() {
    mv $BUILD/$PKG_NAME/$PKG_ADDON_ID-$PKG_VERSION $PKG_BUILD
    rm -rf $BUILD/$PKG_NAME
}

make_target() {
  TexturePacker -input media/ \
                -output Textures.xbt \
                -dupecheck \
                -use_none
}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/share/kodi/addons/${PKG_ADDON_ID}/
    cp -R * $INSTALL/usr/share/kodi/addons/${PKG_ADDON_ID}/
    rm -rf ${INSTALL}/usr/share/kodi/addons/${PKG_ADDON_ID}/media/
    mkdir -p ${INSTALL}/usr/share/kodi/addons/${PKG_ADDON_ID}/media/
    mv Textures.xbt ${INSTALL}/usr/share/kodi/addons/${PKG_ADDON_ID}/media/
}
