#!/usr/bin/env bash

apt update -y
apt build-dep -y python3
apt install -y \
  pkg-config \
  build-essential \
  gdb \
  lcov \
  pkg-config \
  libbz2-dev \
  libffi-dev \
  libgdbm-dev \
  libgdbm-compat-dev \
  liblzma-dev \
  libncurses5-dev \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  lzma \
  lzma-dev \
  tk-dev \
  uuid-dev \
  zlib1g-dev

  # Not present in Ubuntu, but python will build without it:
  # https://askubuntu.com/questions/1520401/unable-to-get-libmpdec-dev-from-remote-repository-on-ubuntu-24-04using-apt-get

  # libmpdec-dev
