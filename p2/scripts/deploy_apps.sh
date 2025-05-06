#!/bin/bash

# applay all confs/*.yaml
for file in /home/vagrant/confs/*/*.yaml; do
  if [ -f "$file" ]; then
    echo "Applying $file..."
    sudo kubectl apply -f "$file"
  else
    echo "No YAML files found in /home/vagrant/confs/"
    exit 1
  fi
done

sudo kubectl apply -f /home/vagrant/confs/ingress.yaml