#!/bin/bash

./setenv.sh
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
  mkdir -p ../sd-card
  gnublinRoot="../sd-card"

  # try to mount the SD memory card
  # this requires an entry in /etc/fstab such as
  # UUID=386b3be7-00f3-45e0-832e-1f48c2c3065e /home/slopjong/workspaces/gnublinux/sd-card ext2 users,noauto 0 0
  # where UUID is the partition UID which can be found out with blkid (run as root)
  mount ../sd-card > /dev/null 2>&1
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
