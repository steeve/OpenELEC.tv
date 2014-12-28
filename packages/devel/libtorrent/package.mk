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
echo "sourcing libtorrent-rasterbar/package.mk: $@"

PKG_NAME="libtorrent-rasterbar"
PKG_VERSION="1.0.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.boost.org/"
PKG_URL="http://garr.dl.sourceforge.net/project/libtorrent/libtorrent/${PKG_NAME}-${PKG_VERSION}.tar.gz"
#PKG_SOURCE_DIR="${PKG_NAME}-${PKG_VERSION}"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain boost Python:host Python:target zlib bzip2"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="libtorrent is a feature complete C++ bittorrent implementation focusing on efficiency and scalability."
PKG_LONGDESC="libtorrent is a feature complete C++ bittorrent implementation focusing on efficiency and scalability. It runs on embedded devices as well as desktops. It boasts a well documented library interface that is easy to use. It comes with a simple bittorrent client demonstrating the use of the library."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
export CFLAGS="$CFLAGS -I$ROOT/$PKG_BUILD/include/"
export CXXFLAGS="$CXXFLAGS -I$ROOT/$PKG_BUILD/include/"
export PYTHON_VERSION="2.7"
export PYTHON_CPPFLAGS="-I$SYSROOT_PREFIX/usr/include/python$PYTHON_VERSION -I$ROOT/$PKG_BUILD/include/"
export PYTHON_LDFLAGS="-L$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION -lpython$PYTHON_VERSION"
export PYTHON_SITE_PKG="$SYSROOT_PREFIX/usr/lib/python$PYTHON_VERSION/site-packages"


PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
        --with-boost-libdir=$SYSROOT_PREFIX/usr/lib \
        --with-boost-python=mt \
        --with-openssl=$SYSROOT_PREFIX/usr \
        --prefix=/usr \
         --enable-export-all \
        --disable-debug \
        --enable-python-binding"
echo $PKG_CONFIGURE_OPTS_TARGET
post_configure_target()
{
    cp -R $ROOT/$PKG_BUILD/bindings/python $ROOT/$PKG_BUILD/.$TARGET_NAME/bindings
}