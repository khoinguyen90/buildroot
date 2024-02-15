#!/usr/bin/env bash
set -e

GIT_SOURCE=${CONFIG_DIR}/../
UBOOT_SOURCE=${GIT_SOURCE}/uboot-rockchip
RKBIN=${GIT_SOURCE}/rkbin
BR2_EXTERNAL_PRAXIS_PATH=${GIT_SOURCE}/buildroot


# copy uboot variable file over
cp -a $BR2_EXTERNAL_PRAXIS_PATH/board/praxis/linux-tft/vars.txt $BINARIES_DIR/

# Build uboot
echo create uboot.img
cd ${GIT_SOURCE}
cd uboot-rockchip; ./make.sh rk3568
cp uboot.img $BINARIES_DIR/u-boot.itb

# Make idbloader.img
$UBOOT_SOURCE/tools/mkimage -n rk3568 -T rksd -d $RKBIN/bin/rk35/rk3568_ddr_1056MHz_v1.18.bin:$UBOOT_SOURCE/spl/u-boot-spl.bin $BINARIES_DIR/idbloader.img

# Generate the uboot script
#$HOST_DIR/bin/mkimage -C none -A arm -T script -d $BR2_EXTERNAL_PRAXIS_PATH/board/praxis/linux-tft/boot.cmd $BINARIES_DIR/boot.scr

# Put the device trees into the correct location
cd ${BINARIES_DIR}
cp ${BASE_DIR}/build/host-genimage-16/genimage "${BINARIES_DIR}"
mkdir -p $BINARIES_DIR/rockchip; cp -a $BINARIES_DIR/*.dtb $BINARIES_DIR/rockchip
$BASE_DIR/../support/scripts/genimage.sh -c $BR2_EXTERNAL_PRAXIS_PATH/board/praxis/linux-tft/genimage.cfg
