#!/bin/bash

# If we are sudo exit
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run using sudo or as the root user"
    exit 1
fi

# Load the project settings
source ../source_dir_arex_qemu.sh


# export the Libary
export LD_LIBRARY_PATH=$DIR_SYSTEMC_LIBRARY_FOLDER 

# start the demo
eval $DIR_CoSimDemo_FOLDER/zynqmp_demo unix:$DIR_QEMU_SHARED_FOLDER/qemu-rport-_amba@0_cosim@0 $SYNC_QUANTUM_VALUE
