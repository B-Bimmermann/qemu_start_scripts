#!/bin/bash

# If we are sudo exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run using sudo or as the root user"
    exit 1
fi


#1. ###################################################################################
DIR_QEMU="/home/bimmermann/Masterarbeit/qemu-xilinx"
DIR_QEMU_SHARED_FOLDER="/home/bimmermann/Masterarbeit/qemu_shared_folder"

DIR_DEVICE_TREES_XILINX="/home/bimmermann/Masterarbeit/xilinx-qemu-devicetrees/LATEST/MULTI_ARCH"
DIR_PETALINUX_ZCU102_PROJECT="/media/bimmermann/petalinux-platte/xilinx-zcu102-2017.3"

DIR_SYSTEMC_LIBRARY_FOLDER="/home/bimmermann/Masterarbeit/systemc-2.3.1a/lib-linux64/"
DIR_CoSimDemo_FOLDER="/home/bimmermann/Masterarbeit/GITHUB-AREX/systemctlm-cosim-demo/"
#######################################################################################

#2. ###################################################################################
# telnet adress
MON_ADDR="127.0.0.1"

# random port number for monitoring port
MON_PORT=$( shuf -i 10000-64000 -n 1)
GDB_PORT=$( shuf -i 10000-64000 -n 1)
#######################################################################################

#3. ###################################################################################
ICOUNT_VALUE=1
SYNC_QUANTUM_VALUE=10000
#######################################################################################

