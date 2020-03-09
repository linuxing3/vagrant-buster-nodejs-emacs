#!/usr/bin/env bash

if [ -e "/etc/vagrant-provisioned" ];
then
    echo "Vagrant provisioning already completed. Restarting..."
    rm /etc/vagrant-provisioned
    # exit 0
else
    echo "Starting Vagrant provisioning process..."
fi

echo `cat /etc/vagrant-provisioned`
echo `cat /home/vagrant/.bashrc`

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 10.0.2.15"