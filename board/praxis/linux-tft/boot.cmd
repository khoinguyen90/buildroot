echo "loading boot vars"
setenv load_addr $ramdisk_addr_r
setenv devnum 0

echo "setting boot args"
setenv bootargs "root=/dev/mmcblk1p2 earlyprintk console=ttyS2,1500000n8 rw rootwait"
fatload mmc ${devnum}:${distro_bootpart} ${fdt_addr_r} rockchip/rk3568-praxis-tft.dtb
fatload mmc ${devnum}:${distro_bootpart} ${kernel_addr_r} Image

echo "booting linux ..."
booti ${kernel_addr_r} - ${fdt_addr_r}