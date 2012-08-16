#!/bin/bash

cd linux*

# remove untracked folders
rm -rf .tmp_versions drivers/lpc313x_io include/config include/generated/

# remove untracked files
git clean -f

# revert all the changes done after the last commit
git stash #save clean_56123j123g124
git stash drop #clean_56123j123g124

# patch again
#../patch.sh
echo "Don't forget to reapply the patch if you rebuild the kernel and its modules."
