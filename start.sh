#! /bin/bash

# Delete previous ConfigMaps
kubectl delete configmap canasta-settings 2>/dev/null
kubectl delete configmap canasta-config 2>/dev/null
kubectl delete configmap canasta-env 2>/dev/null

# Create ConfigMaps from the configuration files
kubectl create configmap canasta-settings --from-file=./settings/
kubectl create configmap canasta-config --from-file=./config/

# Ensure host directories exist for PersistentVolumes
mkdir -p /canasta/persistent/caddy-data
mkdir -p /canasta/persistent/mysql-data
mkdir -p /canasta/persistent/sitemap-data
mkdir -p /canasta/persistent/varnish-data
mkdir -p /canasta/config-data/_initdb

kubectl create configmap canasta-env --from-env-file=.env

# Create all the Kubernetes deployments, services and related objects
kubectl apply -f Kubernetes/
