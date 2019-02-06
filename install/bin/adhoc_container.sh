#!/bin/bash

source ./conf/.env.sh

export OPERATION="ADHOC_CONTAINER"

cd $GIT_WORK_FOLDER
git pull origin $EXECUTION_NAME

CONTAINER=$1

$PRECISION100_FOLDER/exec_container.sh $CONTAINER
