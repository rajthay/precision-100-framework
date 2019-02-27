#!/bin/bash

source ./conf/.env.sh

if [ $REPO_TYPE == "FILE" ]
then
cp -R $REPO_URL $GIT_WORK_FOLDER

else 
git clone "$REPO_URL" "$GIT_WORK_FOLDER"
fi
