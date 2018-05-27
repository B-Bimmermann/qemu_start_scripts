#!/bin/bash

# If we are sudo exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run using sudo or as the root user"
    exit 1
fi

# Set the VM Name
VM_NAME="QEMU_XILINX_XCU102_MICROBLAZE"

# Load the project settings
source ../source_dir_arex_qemu.sh

# Set the Path to the QEMU SYSTEM
VM_SYSTEM_DIR_BASE="$DIR_QEMU/microblazeel-softmmu/qemu-system-microblazeel "

# Show some Infos
echo "[INFO] Telnet    : telnet $MON_ADDR $MON_PORT"
echo "[INFO] GDB       : gdb    $GDB_PORT"

# -hw-dtb $DIR_DEVICE_TREES_XILINX/zynqmp-pmu.dtb 

# Create the QEMU command Line
VM_CMD_LINE=" \
-name $VM_NAME \
-nographic \
-display none \
-monitor telnet:$MON_ADDR:$MON_PORT,server,nowait \
-gdb tcp::$GDB_PORT \
 \
-M microblaze-fdt \
-device loader,addr=0xfd1a0074,data=0x1011003,data-len=4 \
-device loader,addr=0xfd1a007C,data=0x1010f03,data-len=4 \
\
-kernel $DIR_PETALINUX_ZCU102_PROJECT/pre-built/linux/images/pmu_rom_qemu_sha3.elf \
-device loader,file=$DIR_PETALINUX_ZCU102_PROJECT/images/linux/pmufw.elf \
 \
-machine-path $DIR_QEMU_SHARED_FOLDER \
\
-sync-quantum $SYNC_QUANTUM_VALUE \
-hw-dtb $DIR_PETALINUX_ZCU102_PROJECT/images/linux/zynqmp-qemu-multiarch-pmu.dtb \   
 \
 "
# Build the VM command
VM_START_LINE="$VM_SYSTEM_DIR_BASE $VM_CMD_LINE"

# Running a Zynq UltraScale+ Linux Kernel Image On Xilinx's ARM/PMU QEMU
echo "[INFO] Start qemu"
echo "[INFO] VM Name          : $VM_NAME"
echo "[INFO] QEMU command line: $VM_START_LINE"
echo ""
echo "-------------------------------------------------------------------------------------"
echo ""


eval $VM_START_LINE

