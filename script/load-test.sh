#!/bin/bash
set -e

echo "Starting port-forward for ingress..."

kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80 > /dev/null 2>&1 &
PF_PID=$!

sleep 5

echo "Running load test..."

k6 run --out json=loadtest/result.json loadtest/test.js

kill $PF_PID

echo "Load test completed"

