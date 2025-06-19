#!/bin/bash

kubectl create namespace dev
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl rollout status -n argocd deployments --timeout=300s
kubectl apply -f ./confs/application.yaml 