#!/bin/bash

WORKFLOW="aur-build.yml"
REPO="asahi-xd/AUR-Build"

echo "Running the workflow...\n"
echo "Building packages: $@"

gh workflow run \
    "$WORKFLOW" -R "$REPO" \
    -f packages="$@" \
    && sleep 5 \
    && RUN_ID=$(gh run list --workflow=$WORKFLOW -R $REPO --limit 1 --json databaseId --jq '.[0].databaseId') \
    && gh run -R "$REPO" watch $RUN_ID \
    && gh run -R "$REPO" download $RUN_ID \
    && ARTIFACT_NAME=$(gh api repos/$REPO/actions/runs/$RUN_ID/artifacts --jq '.artifacts[0].name') \
    && echo $ARTIFACT_NAME

