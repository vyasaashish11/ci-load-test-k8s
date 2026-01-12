#!/bin/bash
set -e

CLUSTER_NAME="ci-cluster"

echo "Installing KinD..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "Deleting existing cluster (if any)..."
kind delete cluster --name $CLUSTER_NAME || true

echo "Creating Kubernetes cluster with 2 workers..."
kind create cluster --config k8s/kind-config.yaml --name $CLUSTER_NAME

echo "Cluster created"

kubectl cluster-info
kubectl get nodes
