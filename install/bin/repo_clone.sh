#!/bin/bash

if [ $REPO_TYPE == "FILE" ]
then
cp -R $REPO_URL $REPO_WORK_FOLDER

elif [ $REPO_TYPE == "GIT" -o $REPO_TYPE == "HTTPS" ]
then
git clone "$REPO_URL" "$REPO_WORK_FOLDER"
fi
