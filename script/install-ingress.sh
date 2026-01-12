#!/bin/bash
set -e

echo "Installing NGINX Ingress Controller..."

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

echo "Waiting for ingress-nginx namespace..."
kubectl wait --for=condition=Ready pods --all -n ingress-nginx --timeout=180s || true

echo "Ingress controller pods:"
kubectl get pods -n ingress-nginx

echo "Ingress services:"
kubectl get svc -n ingress-nginx

