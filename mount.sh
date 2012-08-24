#!/bin/bash

# try to mount the SD memory card
# this requires an entry in /etc/fstab such as
# UUID=386b3be7-00f3-45e0-832e-1f48c2c3065e /home/slopjong/workspaces/gnublinux/sd-card ext2 users,noauto 0 0
# where UUID is the partition UID which can be found out with blkid (run as root)
mount sd-card > /dev/null 2>&1
