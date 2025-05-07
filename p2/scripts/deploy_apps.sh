#!/bin/bash

# apply ingress-nginx
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

# apply all confs/*.yaml
sudo kubectl apply -f /home/vagrant/confs/app-one/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-one/service.yaml
sudo kubectl apply -f /home/vagrant/confs/app-two/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-two/service.yaml
sudo kubectl apply -f /home/vagrant/confs/app-three/deploy.yaml
sudo kubectl apply -f /home/vagrant/confs/app-three/service.yaml
sudo kubectl apply -f /home/vagrant/confs/ingress.yaml