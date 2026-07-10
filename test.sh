#!/bin/bash

WORKFLOW="aur-build.yml"
REPO="asahi-xd/AUR-Build"
LOCAL_REPO_NAME="gh-aur-builds"
LOCAL_REPO_DIR="/mnt/Data_Drive/.local/repo"

echo "Verifying that the package names provided are valid...\n"

packages=("$@")
errcount=0

for i in ${packages[@]}; do
    # check if yay -Si output contains "No AUR package found" text.
    # if it does then errcount+=1
    # Also increment i to a list

if errcount > 0:
    # exit the script
    echo "Invalid package names provided:"
    echo "That list"
    exit


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
    # This should then move the package files to the local repo directory,
    # and return some kind of confirmation that its done
    # ... WIP

# Add a logic block to have it execute iff the workflow ran properly without errors.
repo-add "$LOCAL_REPO_DIR"/"$LOCAL_REPO_NAME"/"$LOCAL_REPO_NAME".db.tar.zst ./*.pkg.tar.zst


