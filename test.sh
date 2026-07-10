#!/bin/bash

echo "Running the workflow..."

#gh workflow run aur-build.yml -R asahi-xd/AUR-Build -f packages="$@" && sleep 5 && RUN_ID=$(gh run list --workflow=aur-build.yml -R asahi-xd/AUR-Build --limit 1 --json databaseId --jq '.[0].databaseId') && gh run -R asahi-xd/AUR-Build watch $RUN_ID && gh run -R asahi-xd/AUR-Build download $RUN_ID


gh workflow run \
    aur-build.yml -R asahi-xd/AUR-Build \
    -f packages="$@" \

    && sleep 5 \

    && RUN_ID=$(gh run list --workflow=aur-build.yml -R asahi-xd/AUR-Build --limit 1 --json databaseId --jq '.[0].databaseId') \

    && gh run -R asahi-xd/AUR-Build watch $RUN_ID \

    && gh run -R asahi-xd/AUR-Build download $RUN_ID


# Query the GitHub API for the artifact name
#ARTIFACT_NAME=$(gh api repos/asahi-xd/AUR-Build/actions/runs/$RUN_ID/artifacts --jq '.artifacts[0].name')

# Download using the dynamically fetched name
#gh run download $RUN_ID -R asahi-xd/AUR-Build -n "$ARTIFACT_NAME" -D .

