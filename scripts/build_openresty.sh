#!/bin/bash
# Build OpenResty and modules for Heroku.
# This script is designed to run in a Heroku Stack Docker
# image. More information on the Heroku Stack can be found
# at https://devcenter.heroku.com/articles/stack
set -euo pipefail -x

OPENRESTY_VERSION="${OPENRESTY_VERSION-1.19.3.1}"
OPENRESTY_SOURCE_URL="https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz"

LUAROCKS_VERSION="${LUAROCKS_VERSION-3.4.0}"
LUAROCKS_SOURCE_URL="https://github.com/luarocks/luarocks/archive/v${LUAROCKS_VERSION}.tar.gz"

TEMP_DIR="$(mktemp -d /tmp/openresty-${OPENRESTY_VERSION}.XXXXXXXXXX)"
INSTALL_DIR="/app/openresty"


curl -L "$OPENRESTY_SOURCE_URL" | tar zxv -C "$TEMP_DIR"
curl -L "$LUAROCKS_SOURCE_URL" | tar zxv -C "$TEMP_DIR"

ls -la "$TEMP_DIR"

mkdir -p "$INSTALL_DIR"
cd "$TEMP_DIR/openresty-${OPENRESTY_VERSION}"
./configure \
  -j8 \
  --with-pcre-jit \
  --with-http_gzip_static_module \
  --with-http_realip_module \
  --with-http_ssl_module \
  --prefix="$INSTALL_DIR"
make -j8
make install

export PATH="$PATH:$INSTALL_DIR/bin:$INSTALL_DIR/luajit/bin:$INSTALL_DIR/luarocks/bin"

cd "$TEMP_DIR/luarocks-${LUAROCKS_VERSION}"
./configure --prefix="$INSTALL_DIR/luarocks" --with-lua="$INSTALL_DIR/luajit"
make
make install

cd

luajit -v
openresty -V
luarocks --version

luarocks install lapis

openresty -V >& "$INSTALL_DIR/openresty-V.txt"

cd "$(dirname "$INSTALL_DIR")"

tar -zcvf /tmp/openresty-"${STACK}".tar.gz .
cp /tmp/openresty-"${STACK}".tar.gz "$1"
