#!/usr/bin/env bash

echo "==========================================================="
echo "setting ssh"
echo "==========================================================="


# Setup keys for vagrant user.
echo "Setting ssh for vagrant"
VAGRANT_HOME="/home/vagrant"
VAGRANT_SSH_HOME="$VAGRANT_HOME/.ssh"
VAGRANT_AUTHORIZED_KEYS="$VAGRANT_SSH_HOME/authorized_keys"

# ssh-keygen -C vagrant@localhost -f "$VAGRANT_SSH_HOME/id_rsa" -q -N ""
cat "$VAGRANT_SSH_HOME/id_rsa.pub" >> "$VAGRANT_AUTHORIZED_KEYS"
cat "/vagrant/keys/id_rsa.pub" >> "$VAGRANT_AUTHORIZED_KEYS"
chmod 644 "$VAGRANT_AUTHORIZED_KEYS"
chown -R vagrant:vagrant "$VAGRANT_SSH_HOME"


# Setup keys for root user.
echo "Setting ssh for root"
ROOT_HOME="/root"
ROOT_SSH_HOME="$ROOT_HOME/.ssh"
ROOT_AUTHORIZED_KEYS="$ROOT_SSH_HOME/authorized_keys"

[ -s "$ROOT_SSH_HOME" ] && rm -rf "$ROOT_SSH_HOME"
ssh-keygen -C root@localhost -f "$ROOT_SSH_HOME/id_rsa" -q -N ""

cat "$ROOT_SSH_HOME/id_rsa.pub" >> "$ROOT_AUTHORIZED_KEYS"
cat "$VAGRANT_SSH_HOME/id_rsa.pub" >> "$ROOT_AUTHORIZED_KEYS"
cat "/vagrant/keys/id_rsa.pub" >> "$VAGRANT_AUTHORIZED_KEYS"

chmod 644 "$ROOT_AUTHORIZED_KEYS"