#!/usr/bin/env bash

if [ -e "/etc/vagrant-provisioned" ];
then
    echo "Vagrant provisioning already completed. Restarting..."
    rm /etc/vagrant-provisioned
    # exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

# Change the hostname so we can easily identify what environment we're on:
echo "buster-vagrant" > /etc/hostname
# Update /etc/hosts to match new hostname to avoid "Unable to resolve hostname" issue:
echo "127.0.0.1 buster-vagrant" >> /etc/hosts
echo "10.0.2.2 host" >> /etc/hosts
# Use hostname command so that the new hostname takes effect immediately without a restart:
hostname nodejs-vagrant

# Install core components
/vagrant/sh/core.sh

# ssh settings
/vagrant/sh/ssh.sh

# Vim settings:
/vagrant/sh/vim.sh

# GitHub repositories:
/vagrant/sh/github.sh

# Install Node.js
/vagrant/sh/nodejs.sh

# Python settings
/vagrant/sh/python.sh

# oh-my-bash settings
/vagrant/sh/bash.sh

# oh-my-tmux settings
/vagrant/sh/tmux.sh

touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 10.0.2.15"