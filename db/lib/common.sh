#!/bin/sh

# Copyright 2022 draumaz
# Distributed under the terms of the MIT license

basic_uninstall() {
  test -e "$1" || die 1
}

basic_environment_setup() {
  mkdir -pv db/work/$PKG_TITLE && cd db/work/$PKG_TITLE
  package_sources
  cd $PKG_TITLE-$PKG_VERSION
}

basic_environment_build_nest() {
  mkdir -pv build
  cd build
}

basic_install_mini() {
  make install
}

basic_install() {
  make &&
  basic_install_mini &&
  cd ..
  rm -rf $PKG_TITLE
}

basic_install_cmake() {
  cmake . &&
  basic_install
}

basic_install_ninja() {
  meson .. &&
  ninja &&
  ninja install
}
