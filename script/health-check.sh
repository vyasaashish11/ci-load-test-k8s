#!/bin/bash
set -e

echo "Checking cluster nodes..."
kubectl get nodes

echo "Checking ingress controller..."
kubectl get pods -n ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

echo "Checking foo deployment..."
kubectl rollout status deployment/foo

echo "Checking bar deployment..."
kubectl rollout status deployment/bar

echo "Health checks passed!"

echo "Testing ingress routing..."

kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80 &
PF_PID=$!

sleep 5

FOO_RESPONSE=$(curl -s -H "Host: foo.localhost" http://localhost:8080)
BAR_RESPONSE=$(curl -s -H "Host: bar.localhost" http://localhost:8080)

kill $PF_PID

if [[ "$FOO_RESPONSE" != "foo" ]]; then
  echo "Foo routing failed"
  exit 1
fi

if [[ "$BAR_RESPONSE" != "bar" ]]; then
  echo "Bar routing failed"
  exit 1
fi

echo "Ingress routing checks passed!"

