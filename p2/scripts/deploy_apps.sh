#!/bin/bash

# apply all confs/*.yaml
sudo kubectl apply -f /home/vagrant/confs/app-one/config.yaml
sudo kubectl apply -f /home/vagrant/confs/app-one/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-one/service.yaml

sudo kubectl apply -f /home/vagrant/confs/app-two/config.yaml
sudo kubectl apply -f /home/vagrant/confs/app-two/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-two/service.yaml

sudo kubectl apply -f /home/vagrant/confs/app-three/config.yaml
sudo kubectl apply -f /home/vagrant/confs/app-three/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-three/service.yaml

# # wait for all pods to be ready
until kubectl get pods -l app=app-one | grep -v NAME; do
  echo "Waiting for pods to be created..."
  sleep 2
done

until kubectl get pods -l app=app-two | grep -v NAME; do
  echo "Waiting for pods to be created..."
  sleep 2
done

until kubectl get pods -l app=app-three | grep -v NAME; do
  echo "Waiting for pods to be created..."
  sleep 2
done

sudo kubectl wait --for=condition=ready pod --all --timeout=300s
sudo kubectl apply -f /home/vagrant/confs/ingress.yaml