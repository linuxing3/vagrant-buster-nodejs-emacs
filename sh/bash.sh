#!/usr/bin/env bash

echo "==========================================================="
echo "installing oh-my-bash"
echo "==========================================================="
# using oh-my-bash, fish is not good in console2 and other win tty
VAGRANT_HOME="/home/vagrant"
cd $VAGRANT_HOME
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"