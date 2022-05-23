#!/usr/bin/env bash

PKG_REPO="https://github.com/dpayne/cli-visualizer"
PKG_NAME="${PKG_REPO##*/}"

true << EOF
DEB_DEPS libfftw3-dev libncursesw5-dev cmake gcc g++ libpulse-dev
RPM_DEPS fftw-devel ncurses-devel cmake gcc g++ pulseaudio-libs-devel
ARCH_DEPS ftw ncurses cmake
EOF

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf CMakeFiles vis"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR

  if cmake .; then true; else
    printf "$PKG_NAME: failed to generate makefile.\n"
    exit
  fi
  
  if make -{j,l}$(nproc); then true; else
    printf "$PKG_NAME: failed to compile.\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
