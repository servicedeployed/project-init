#!/bin/bash

# Download single YAML File
if [[ $URL =~ yaml$ ]]; then 
    curl -L $URL --output /project/init.yaml

# Clone public or private git repository
elif [[ $URL =~ git$ ]]; then
    
    # Check if Token is Empty
    if [[ -z "${OAUTH_TOKEN}" ]]; then
        REPLACE_TOKEN=""
    else
        REPLACE_TOKEN="${OAUTH_TOKEN}@"
    fi

    # Works for GitHub & GitLab Repositories
    if [[ "$URL" == *"gitlab.com"* ]]; then
        URL=$(echo $URL | sed "s/https:\/\//https:\/\/gitlab-ci-token:$REPLACE_TOKEN/g")
    else
        URL=$(echo $URL | sed "s/https:\/\//https:\/\/$REPLACE_TOKEN/g")
    fi

    echo "Cloning: $URL to /project"
    
    git clone $URL /project
    exit 1
else
    exit 0
fi