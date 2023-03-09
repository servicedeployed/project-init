#!/bin/bash

GIT_CLONE_DIR="${PROJECT_DIR:=/project}"

# Download single YAML File
if [[ $URL =~ yaml$ ]]; then 
    curl -L $URL --output $GIT_CLONE_DIR/init.yaml

# Clone public or private git repository
elif [[ $URL =~ git$ ]]; then
    
    # Check if Token is Empty
    if [[ -z "${OAUTH_TOKEN}" ]]; then
        REPLACE_TOKEN=""
    else
        # Works for GitHub & GitLab Repositories
        if [[ "$URL" == *"gitlab.com"* ]]; then
            REPLACE_TOKEN="gitlab-ci-token:${OAUTH_TOKEN}@"
        else
            REPLACE_TOKEN="${OAUTH_TOKEN}@"
        fi
    fi

    URL=$(echo $URL | sed "s/https:\/\//https:\/\/$REPLACE_TOKEN/g")
    echo "Cloning: $URL to $GIT_CLONE_DIR"
    
    # Check if Git branch is Empty
    if [[ -z "${GIT_BRANCH}" ]]; then
        git clone --quiet \
            $URL $GIT_CLONE_DIR
    else
        git clone \
            -c advice.detachedHead=false \
            --quiet \
            --branch $GIT_BRANCH $URL $GIT_CLONE_DIR
    fi
    
    exit 0
else
    exit 1
fi