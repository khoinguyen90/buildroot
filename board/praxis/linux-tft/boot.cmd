echo "loadaddr = " ${loadaddr}
echo "fdt_addr_r = " ${fdt_addr_r}
echo "kernel_addr_r = " ${kernel_addr_r}

setenv bootargs root=/dev/mmcblk1p2 rw rootfstype=ext4 clkin_hz=(25000000) earlycon clk_ignore_unused earlyprintk console=ttyS2,1500000n8 rootwait
fatload mmc 0:1 ${loadaddr} image.itb
bootm ${loadaddr}