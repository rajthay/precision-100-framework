#!/bin/bash

source ./conf/.env.sh

if [ $REPO_TYPE == "GIT" -o $REPO_TYPE == "HTTPS" ]
then

git branch "$EXECUTION_NAME"
git checkout "$EXECUTION_NAME"

git push -u origin "$EXECUTION_NAME"

fi

