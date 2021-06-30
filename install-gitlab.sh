#!/bin/sh

# Guide used: https://docs.gitlab.com/charts/quickstart/index.html

# Add gitlab repo to helm
helm repo add gitlab https://charts.gitlab.io/

# Install gitlab
helm install gitlab gitlab/gitlab \
  --set global.hosts.domain=gitlab.petmoreno.net \
  --set certmanager-issuer.email=pethermoreno@gmail.com

# You can get you public IP with the command
kubectl get ingress -lrelease=gitlab

# You will need to put in your hosts, if you are working locally the domains you plan to use
# for example
# 192.168.15.11	gitlab.gitlab.petmoreno.net
# 192.168.15.11	registry.gitlab.petmoreno.net
# 192.168.15.11	minio.gitlab.petmoreno.net

# After gitlab is ready, get password to root user
kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo