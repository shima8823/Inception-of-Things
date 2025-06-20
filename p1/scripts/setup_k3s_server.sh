#!/bin/bash

# 必要なパッケージのインストール
apt-get update
apt-get install -y curl wget git vim

# K3sをコントローラーモードでインストール
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110" sh -

# トークンを共有ディレクトリに保存（ワーカーノードがアクセスできるように）
while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
  sleep 1
done
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
sudo chmod 644 /vagrant/node-token 