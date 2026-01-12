#!/bin/bash

FILE="loadtest/result.json"

AVG=$(jq '.metrics.http_req_duration.values.avg' $FILE)
P90=$(jq '.metrics.http_req_duration.values["p(90)"]' $FILE)
P95=$(jq '.metrics.http_req_duration.values["p(95)"]' $FILE)
REQS=$(jq '.metrics.http_reqs.values.rate' $FILE)
FAILED=$(jq '.metrics.http_req_failed.values.rate' $FILE)

cat <<EOF > report.md
## 🚀 Load Test Report

| Metric | Value |
|--------|-------|
| Avg Latency | ${AVG} ms |
| p90 Latency | ${P90} ms |
| p95 Latency | ${P95} ms |
| Error Rate | ${FAILED}% |
| Requests/sec | ${REQS} |

EOF

