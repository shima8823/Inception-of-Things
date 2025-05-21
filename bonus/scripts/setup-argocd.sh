#!/bin/bash

k3d cluster create iot-shshimad-bonus --port 8888:8888@loadbalancer

kubectl create namespace dev
kubectl create namespace argocd

# argocd install
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# wait for argocd pods to be ready 
kubectl rollout status -n argocd deployments --timeout=300s

# create argocd app
kubectl apply -f ./confs/application.yaml

# argocd port forward
# stdout and stderr to /dev/null
kubectl port-forward svc/argocd-server -n argocd 8080:80 > /dev/null 2>&1 &
echo "argocd processId: $\!"
echo "argocd url: http://127.0.0.1:8080"
echo "argocd password: $(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)"
