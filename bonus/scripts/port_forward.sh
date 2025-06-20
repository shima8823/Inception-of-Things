#!/bin/bash

# ArgoCD
kubectl port-forward svc/argocd-server -n argocd 8080:80 > /dev/null 2>&1 &
echo "argocd processId: $!"
echo "argocd url: http://127.0.0.1:8080"
echo "argocd password: $(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)"

# GitLab
kubectl port-forward svc/gitlab-webservice-default -n gitlab 8081:8181 > /dev/null 2>&1 &
echo "gitlab processId: $!"
echo "gitlab url: http://127.0.0.1:8081"
echo "gitlab password: $(kubectl get secret -n gitlab gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" | base64 -d)"