#!/bin/bash
set -e

echo "Installing KinD..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "Creating Kubernetes cluster..."
kind create cluster --config /home/system/CI-Load-Test/k8s/kind.config.yaml --name ci-cluster

echo "Cluster created"

kubectl cluster-info
kubectl get nodes

