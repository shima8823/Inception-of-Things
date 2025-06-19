#!/bin/bash

k3d cluster create iot-shshimad-bonus --port 8888:8888@loadbalancer

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  -f confs/values.yaml \
  --namespace gitlab \
  --create-namespace \
  --set certmanager-issuer.email=me@example.com \
  --set global.edition=ce

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

# gitlab port forward

kubectl port-forward svc/gitlab-webservice-default -n gitlab 8081:8181 --address 0.0.0.0 > /dev/null 2>&1 &

echo "gitlab processId: $\!"
echo "gitlab url: http://127.0.0.1:8081"
echo "gitlab password: $(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d)"
