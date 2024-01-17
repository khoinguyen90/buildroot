#!/usr/bin/env bash
set -e

gzip -fk "${BINARIES_DIR}/Image"
cp board/praxis/linux-tft/linux-tft.its "${BINARIES_DIR}"
cd "${BINARIES_DIR}"
./../../../u-boot/tools/mkimage -f linux-tft.its image.itb
cp ./../build/host-genimage-16/genimage "${BINARIES_DIR}"
./../../support/scripts/genimage.sh -c ./../../board/praxis/linux-tft/genimage.cfg
