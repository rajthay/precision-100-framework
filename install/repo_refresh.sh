#!/bin/bash

source ./conf/.env.sh

if [ $REPO_TYPE != "FILE" ]
then
EXECUTION_NAME=$1
git pull origin $EXECUTION_NAME
fi
