#!/bin/bash

apt-get update
apt-get install -y curl wget git vim
echo "alias k='sudo k3s kubectl'" >> /home/vagrant/.bashrc

# Donwlaod and install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110" sh -
