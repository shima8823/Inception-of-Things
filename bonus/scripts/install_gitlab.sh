#!/bin/bash

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  -f confs/values.yaml \
  --namespace gitlab \
  --create-namespace \
  --set certmanager-issuer.email=me@example.com \
  --set global.edition=ce