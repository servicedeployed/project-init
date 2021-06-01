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
        # Works for GitHub & GitLab Repositories
        if [[ "$URL" == *"gitlab.com"* ]]; then
            REPLACE_TOKEN="gitlab-ci-token:${OAUTH_TOKEN}@"
        else
            REPLACE_TOKEN="${OAUTH_TOKEN}@"
        fi
    fi

    URL=$(echo $URL | sed "s/https:\/\//https:\/\/$REPLACE_TOKEN/g")
    echo "Cloning: $URL to /project"
    
    git clone $URL /project
    exit 0
else
    exit 1
fi