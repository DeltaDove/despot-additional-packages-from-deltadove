#!/usr/bin/env bash

PKG_REPO="https://github.com/Alcaro/Flips"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="g++ pkg-config build-essential"
RPM_DEPS="g++ pkgconf-pkg-config"
ARCH_DEPS="g++ pkgconf make"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp -v flips /usr/local/bin/"
CLEAN_CMD="rm -rf flips"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  bash make.sh
  
  if sudo $INSTALL_CMD; then 
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi

  sudo $CLEAN_CMD
}

$1