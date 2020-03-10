#!/usr/bin/env bash

echo "--------------------------------------------------"
echo "Updating system and packages..."
# Install core components
/vagrant/sh/core.sh
sh/core.sh

echo `ansible`

echo "--------------------------------------------------"
echo "Your vagrant instance is running at: 10.0.2.15"