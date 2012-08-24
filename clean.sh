#!/bin/bash

cd linux*

# remove untracked folders
rm -rf .tmp_versions drivers/lpc313x_io include/config include/generated/

# remove untracked files
git clean -f

# revert all the changes done after the last commit
git stash #save clean_56123j123g124
git stash drop #clean_56123j123g124

# switch back to HEAD
git checkout master

# If the memory card wasn't mounted the kernel and modules got
# not installed to the card but to the directory and thus it must
# be reset.
# be aware that linux* is a submodule and thus another git repository
# with a different index
cd ..
umount sd-card > /dev/null 2>&1
rm -rf sd-card
git checkout sd-card
mount sd-card

# patch again
#../patch.sh
echo "Don't forget to reapply the patch if you rebuild the kernel and its modules."
