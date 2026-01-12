#!/bin/bash

PR_NUMBER=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
REPO=$(jq --raw-output .repository.full_name "$GITHUB_EVENT_PATH")

BODY=$(cat report.md | jq -Rs .)

curl -s -H "Authorization: token $GITHUB_TOKEN" \
     -H "Content-Type: application/json" \
     -X POST \
     -d "{\"body\": $BODY}" \
     "https://api.github.com/repos/$REPO/issues/$PR_NUMBER/comments"

