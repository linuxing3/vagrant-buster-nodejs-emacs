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

echo "--------------------------------------------------"
echo "Updating system and packages..."
# Install core components
/vagrant/sh/core.sh

# ssh settings
/vagrant/sh/ssh.sh

# GitHub repositories:
/vagrant/sh/github.sh


echo "Done!"
echo "--------------------------------------------------"
echo "Setting user customization..."

# oh-my-bash settings
/vagrant/sh/bash.sh
su -c "source /vagrant/sh/bash.sh" vagrant

# oh-my-tmux settings
/vagrant/sh/tmux.sh
su -c "source /vagrant/sh/tmux.sh" vagrant

# Vim settings:
/vagrant/sh/vim.sh
su -c "source /vagrant/sh/vim.sh" vagrant

# Emacs settings:
/vagrant/sh/emacs.sh
su -c "source /vagrant/sh/emacs.sh" vagrant

# Install Node.js
su -c "source /vagrant/sh/nodejs.sh" vagrant

# Python settings
su -c "source /vagrant/sh/python.sh" vagrant

touch /etc/vagrant-provisioned

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 10.0.2.15"