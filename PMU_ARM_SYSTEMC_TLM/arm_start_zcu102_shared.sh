#!/bin/bash

# If we are sudo exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run using sudo or as the root user"
    exit 1
fi

# Set the VM Name
VM_NAME="QEMU_XILINX_XCU102_ARM"

# Load the project settings
source ../source_dir_arex_qemu.sh

# Show some Infos
echo "[INFO] Telnet    : telnet $MON_ADDR $MON_PORT"
echo "[INFO] GDB       : gdb    $GDB_PORT"

# Set the Path to the QEMU SYSTEM
VM_SYSTEM_DIR_BASE="$DIR_QEMU/aarch64-softmmu/qemu-system-aarch64 "


# -hw-dtb $DIR_DEVICE_TREES_XILINX/zcu102-arm.cosim.dtb 

# Create the QEMU command Line
VM_CMD_LINE=" \
-name $VM_NAME \
-nographic \
-no-reboot \
-localtime \
-monitor telnet:$MON_ADDR:$MON_PORT,server,nowait \
-serial mon:stdio \
-serial /dev/null \
-display none \
-gdb tcp::$GDB_PORT \
-M arm-generic-fdt \
-global xlnx,zynqmp-boot.cpu-num=0 \
-global xlnx,zynqmp-boot.use-pmufw=true \
-device loader,file=$DIR_PETALINUX_ZCU102_PROJECT/images/linux/bl31.elf,cpu-num=0 \
-device loader,file=$DIR_PETALINUX_ZCU102_PROJECT/images/linux/Image,addr=0x00080000 \
-device loader,file=$DIR_PETALINUX_ZCU102_PROJECT/images/linux/system.dtb,addr=0x1407f000 \
-device loader,file=$DIR_PETALINUX_ZCU102_PROJECT/build/misc/linux-boot/linux-boot.elf \
 \
-m 4G \
\
-machine-path $DIR_QEMU_SHARED_FOLDER \
-sync-quantum $SYNC_QUANTUM_VALUE \
\
-hw-dtb $DIR_PETALINUX_ZCU102_PROJECT/images/linux/zynqmp-qemu-multiarch-arm.dtb \
 \
 "
# Build the VM command
VM_START_LINE="$VM_SYSTEM_DIR_BASE $VM_CMD_LINE"

# Running a Zynq UltraScale+ Linux Kernel Image On Xilinx's ARM/PMU QEMU
echo "[INFO] QEMU command line: $VM_START_LINE"
echo ""
echo "-------------------------------------------------------------------------------------"
#echo ""
#echo "[INFO] Remove OLD machine shared files"
#rm $DIR_QEMU_SHARED_FOLDER/qemu*
echo "[INFO] Start qemu"

#
#

eval $VM_START_LINE

