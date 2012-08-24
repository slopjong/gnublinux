#!/bin/bash

source ./setenv.sh

cd linux*

# compile the kernel and the modules
make kernel
make modules

gnublinRoot=""

if [ $# -gt 0 ]; then
  gnublinRoot=$1
fi

if [ ! -d "${gnublinRoot}" ]; then
  echo "The path you provided doesn't exist. The built kernel and modules"
  echo "will be installed to sd-card"
  gnublinRoot="../sd-card"
  
  # mount the SD memory card 
  ../mount.sh
fi

# Start a fakeroot session
#fakechroot chroot ${gnublinRoot}

backupCounterFile=${gnublinRoot}/backup_counter
backupCounter=0

# read and increment the backup counter
if [ -f ${backupCounterFile} ]; then
  backupCounter=$(cat ${backupCounterFile})
  # increment the counter, see [0]
  ((backupCounter++))
  echo ${backupCounter} > ${backupCounterFile}
fi

# write the backup counter to the file
echo ${backupCounter} > ${backupCounterFile}

# backup the old kernel and modules
cp ${gnublinRoot}/zImage ${gnublinRoot}/zImage.${backupCounter}
cp -R ${gnublinRoot}/lib/modules ${gnublinRoot}/lib/modules.${backupCounter}

# install the new kernel and modules
make modules_install INSTALL_MOD_PATH=${gnublinRoot}
cp arch/arm/boot/zImage ${gnublinRoot}

## LINKS
#
# [0] http://www.linuxquestions.org/questions/linux-general-1/bash-equivalent-to-c-increment-operator-131504/
