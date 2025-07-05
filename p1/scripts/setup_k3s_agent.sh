#!/bin/bash

# 必要なパッケージのインストール
apt-get update
apt-get install -y curl wget git
echo "alias k='sudo k3s kubectl'" >> /home/vagrant/.bashrc

# トークンを取得
TOKEN=$(cat /vagrant/node-token)

# エージェントとしてK3sをインストール（マスターノードのIPアドレスとトークンを指定）
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$TOKEN sh - 