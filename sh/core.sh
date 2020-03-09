#!/usr/bin/env bash
echo "==========================================================="
echo "update packages"
echo "==========================================================="
# sudo apt-get update

echo "Install core tools"
sudo apt-get install -y tmux git vim wget curl elinks

echo "Install build tools"
sudo apt-get install -y build-essential
sudo apt-get install -y python-software-properties python python3 g++ make
sudo apt-get install -y libcairo2-dev libav-tools nfs-common portmap