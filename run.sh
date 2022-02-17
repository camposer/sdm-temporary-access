#!/bin/bash

# awk 'match($0, /b[^e]*/) {print substr($0, RSTART+1, RLENGTH-1)}

git diff --name-only main | while read line; do 
    raw_resource_name=$line
    raw_user_email=$(bash -c "git log -p -- $line | grep Author | head -1")

    resource_name=$(echo $raw_resource_name | awk '/^resources/ { gsub("resources/", "", $0); print $0 }')
    user_email=$(echo $raw_user_email | awk 'match($0, /<[^e]>/) {print substr($0, RSTART+1, RLENGTH-1)}')

    echo $resource_name
    echo $user_email
done