#!/usr/bin/env bash
echo "==========================================================="
add-apt-repository -y ppa:chris-lea/redis-server
apt-get update
apt-get install -y redis-server