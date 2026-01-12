#!/bin/bash
set -e

echo "Deploying foo..."
kubectl apply -f k8s/foo.yaml

echo "Deploying bar..."
kubectl apply -f k8s/bar.yaml

echo "Waiting for deployments to be ready..."

kubectl rollout status deployment/foo
kubectl rollout status deployment/bar

echo "Deployments ready!"

