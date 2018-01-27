#!/bin/bash

export LD_LIBRARY_PATH=/home/vcap/app/deb/usr/lib/x86_64-linux-gnu
export PATH=$PATH:/home/vcap/app/deb/usr/bin

mkdir deb

pushd deb
  apt-get download poppler-utils libpoppler44

  for deb in *.deb; do
    dpkg -x $deb .
  done

  rm *.deb
popd

if ! pdftotext -v; then
  echo failed to install
  exit 1
fi
